import os
import sys
from langchain_core.prompts import ChatPromptTemplate
from langchain_anthropic import ChatAnthropic
from dotenv import load_dotenv
load_dotenv()

def setup_directories(input_dir, output_dir):
    """Create output directory with the same structure as input directory."""
    if not os.path.exists(input_dir):
        print(f"Error: Input directory '{input_dir}' does not exist.")
        sys.exit(1)
    
    # Create the base output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Copy directory structure
    for root, dirs, _ in os.walk(input_dir):
        rel_path = os.path.relpath(root, input_dir)
        if rel_path == '.':
            continue
        dest_dir = os.path.join(output_dir, rel_path)
        os.makedirs(dest_dir, exist_ok=True)
    
    print(f"Directory structure created successfully in '{output_dir}'")

def split_sql_into_statements(sql_content):
    """Split SQL content into individual CREATE TABLE or other statements."""
    import re
    
    # This pattern looks for CREATE statements and their content until the next CREATE or end of file
    pattern = r"(CREATE\s+(?:TABLE|VIEW|INDEX|TRIGGER|FUNCTION|PROCEDURE|TYPE|SEQUENCE)[^;]*?;)"
    
    # Find all matches
    statements = re.findall(pattern, sql_content, re.IGNORECASE | re.DOTALL)
    
    # If no matches found, return the whole content as a single statement
    if not statements:
        return [sql_content]
    
    # Check if there's content before the first CREATE statement
    first_create_pos = sql_content.find(statements[0])
    if first_create_pos > 0:
        preamble = sql_content[:first_create_pos].strip()
        if preamble:
            statements.insert(0, preamble)
    
    return statements

def convert_sqlite_to_mysql(sql_content):
    """Convert SQLite schema to MySQL using LangChain and an LLM, handling large files by processing in chunks."""
    # Initialize the LLM
    llm = ChatAnthropic(model_name="claude-3-7-sonnet-20250219",
                        temperature=0.0,
                        extra_headers={"anthropic-beta": "output-128k-2025-02-19"},
                        max_tokens=128000,)
    
    # Create the system prompt for conversion
    system_prompt = """You are an expert database engineer with deep knowledge of both SQLite and MySQL. 
    Your task is to convert SQLite syntax to valid MySQL syntax.
    Return ONLY the converted MySQL results with no additional explanations or comments."""
    
    # Split the SQL content into manageable chunks based on CREATE statements
    sql_statements = split_sql_into_statements(sql_content)
    
    # Process each statement separately
    mysql_statements = []
    
    for i, statement in enumerate(sql_statements):
        print(f"  Processing statement {i+1}/{len(sql_statements)}...")
        
        # Create a prompt for this specific statement
        prompt = ChatPromptTemplate.from_messages([
            ("system", system_prompt),
            ("human", f"Convert this SQLite statement to MySQL:\n\n{statement}")
        ])
        
        # Create the chain
        chain = prompt | llm
        
        # Run the conversion
        try:
            result = chain.invoke({})
            mysql_statements.append(result.content)
        except Exception as e:
            print(f"Error processing statement {i+1}: {e}")
            # If there's an error, include the original statement with a comment
            mysql_statements.append(f"-- Error converting statement: \n{statement}")
    
    # Combine all converted statements
    return "\n\n".join(mysql_statements)

def process_directories(input_dir, output_dir):
    """Process all subdirectories, find .sql files, convert them and save to output directory."""
    for root, dirs, files in os.walk(input_dir):
        # Skip the base directory itself
        if root == input_dir:
            continue
        # Get the relative path to maintain the folder structure
        rel_path = os.path.relpath(root, input_dir)
        
        # Check if there are exactly 2 files as per requirement #2
        if len(files) == 2:
            # Find SQL files in this directory
            sql_files = [f for f in files if f.endswith('.sql')]
            
            if sql_files:
                for sql_file in sql_files:
                    input_file_path = os.path.join(root, sql_file)
                    
                    # Create the corresponding output directory and file path
                    output_folder = os.path.join(output_dir, rel_path)
                    output_file_path = os.path.join(output_folder, sql_file)
                    
                    print(f"Processing {input_file_path}...")
                    
                    try:
                        # Read the SQLite schema
                        with open(input_file_path, 'r', encoding='utf-8') as f:
                            sqlite_schema = f.read()
                        
                        # Get the file size for logging
                        file_size = os.path.getsize(input_file_path) / 1024  # in KB
                        print(f"  File size: {file_size:.2f} KB")
                        
                        # Convert to mysql
                        mysql_schema = convert_sqlite_to_mysql(sqlite_schema)
                        
                        # Save the converted schema
                        os.makedirs(output_folder, exist_ok=True)
                        with open(output_file_path, 'w', encoding='utf-8') as f:
                            f.write(mysql_schema)
                        
                        print(f"  Converted schema saved to {output_file_path}")
                    except Exception as e:
                        print(f"  Error processing file {input_file_path}: {str(e)}")
        else:
            print(f"Skipping directory {root} as it doesn't contain exactly 2 files")

def main():
    """Because of context limitations we need to process in chunks and then copy/paste the original insert statements.
    NEEDS to be run outside of the sqlite/store_1 directory."""
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_directory> <output_directory>")
        sys.exit(1)
    
    input_dir = sys.argv[1]
    output_dir = sys.argv[2]
    
    # Set up the directory structure
    setup_directories(input_dir, output_dir)
    
    
    # Count total files to process
    total_folders = 0
    for root, dirs, files in os.walk(input_dir):
        if root != input_dir and len(files) == 2 and any(f.endswith('.sql') for f in files):
            total_folders += 1
    
    print(f"Found {total_folders} folders with SQL files to process")
    
    # Process all directories
    process_directories(input_dir, output_dir)
    
    print("Conversion completed successfully!")

if __name__ == "__main__":
    main()
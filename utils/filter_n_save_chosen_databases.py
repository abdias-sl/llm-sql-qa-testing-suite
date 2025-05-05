import pandas as pd
import os
import math
from datasets import load_dataset

def filter_n_save_chosen_databases():
    dataset_name = "CM/spider"
    num_rows = 5  # Number of rows to display
    chunk_size_mb = 2  # Maximum size for each chunk in MB
    dataset = load_dataset(dataset_name)
            
    print("\nDataset structure:")
    print(dataset)

    # Access the train split
    train_data = dataset["train"]
    print(f"\nTrain split contains {len(train_data)} examples")

    # Convert to pandas DataFrame for easier viewing
    train_df = pd.DataFrame(train_data)

    # Display the first few rows
    print(f"\nFirst {num_rows} rows of the train split:")
    print(train_df.head(num_rows))
    print(train_df.columns)
    #
    with open('assets/chosen_databases.txt', 'r') as f:
        chosen_databases = f.read().splitlines()
    print(f"\nChosen databases: {chosen_databases}")
    # Filter the DataFrame to include only the chosen databases
    filtered_df = train_df[train_df['db_id'].isin(chosen_databases)]
    print(f"\nFiltered DataFrame contains {len(filtered_df)} examples")
    
    columns_to_keep = ['db_id', 'query', 'question', 'query_res']
    for db in chosen_databases:
        split_df = filtered_df[filtered_df['db_id'] == db].reset_index(drop=True)
        split_df = split_df[columns_to_keep]
        
        # Create a temporary CSV to check its size
        temp_file = f'temp_{db}.csv'
        split_df.to_csv(temp_file, index=True, index_label='id')
        
        # Get file size in MB
        file_size_mb = os.path.getsize(temp_file) / (1024 * 1024)
        
        if file_size_mb >= chunk_size_mb:
            # Calculate number of chunks needed
            num_chunks = math.ceil(file_size_mb / chunk_size_mb)
            rows_per_chunk = math.ceil(len(split_df) / num_chunks)
            
            print(f"\nSplitting {db} into {num_chunks} chunks (file size: {file_size_mb:.2f}MB)")
            
            # Create directory for this database
            db_dir = f'questions/{db}'
            os.makedirs(db_dir, exist_ok=True)
            
            # Split and save chunks
            for i in range(num_chunks):
                start_idx = i * rows_per_chunk
                end_idx = min((i + 1) * rows_per_chunk, len(split_df))
                chunk_df = split_df.iloc[start_idx:end_idx].reset_index(drop=True)
                chunk_df.to_csv(f'{db_dir}/chunk_{i+1}_of_{num_chunks}.csv', index=True, index_label='id')
                
            print(f"Saved {db} data in {num_chunks} chunks to {db_dir}/")
        else:
            # Save as a single file in the questions directory
            split_df.to_csv(f'questions/{db}.csv', index=True, index_label='id')
            print(f"Saved {db} data as a single file (size: {file_size_mb:.2f}MB)")
        
        # Remove the temporary file
        os.remove(temp_file)
        
        
        
        
        
        split_df.to_csv(f'questions/{db}.csv', index=True, index_label='id')
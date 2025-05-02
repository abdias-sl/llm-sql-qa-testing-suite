import pandas as pd
from datasets import load_dataset

# the original datasets information function
def show_original_datasets_info():
    dataset_name = "CM/spider"
    num_rows = 5  # Number of rows to display
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
    uniques = train_df['db_id'].unique()
    print(f"\nUnique values in 'db_id' column: {uniques}")
    nuniques = train_df['db_id'].nunique()
    print(f"Number of unique values in 'db_id' column: {nuniques}")
    counts = train_df['db_id'].value_counts()
    pd.set_option('display.max_rows', None)  # Show all rows
    print(f"\nCounts of unique values in 'db_id' column:\n{counts}")



    # Display column information
    print("\nColumn information:")
    for col in train_df.columns:
        print(f"- {col}: {train_df[col].dtype}")
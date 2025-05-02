import pandas as pd
from datasets import load_dataset

def filter_n_save_chosen_databases():
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
        split_df.to_csv(f'questions/{db}.csv', index=True, index_label='id')
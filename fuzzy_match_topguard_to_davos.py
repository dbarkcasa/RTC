# Install dependencies
!pip install pandas openpyxl xlrd rapidfuzz

# Import libraries
import pandas as pd
from rapidfuzz import process, fuzz

# Load the Excel files
topguard_df = pd.read_excel('TopGuard.xls')
davos_df = pd.read_excel('DAVOS.xls')

# Normalize the name columns
topguard_df['TopGuard_Name_clean'] = topguard_df['Team Member name (phonetool link)'].astype(str).str.strip().str.lower()
davos_df['DAVOS_Name_clean'] = davos_df['Counterparty'].astype(str).str.strip().str.lower()

# Perform fuzzy matching
matches = []

for name in topguard_df['TopGuard_Name_clean']:
    match, score, index = process.extractOne(
        name,
        davos_df['DAVOS_Name_clean'],
        scorer=fuzz.token_sort_ratio
    )
    if score >= 85:  # Adjust this threshold if needed
        matched_row = davos_df.iloc[index].copy()
        matched_row['Matched_TopGuard_Name'] = name
        matched_row['Match_Score'] = score
        matches.append(matched_row)

# Save results to CSV
if matches:
    matched_df = pd.DataFrame(matches)
    matched_df.to_csv('matched_davos_rows.csv', index=False)
    print(f"\n✅ Done! Saved {len(matched_df)} matched rows to 'matched_davos_rows.csv'")
else:
    print("\n⚠️ No matches found above threshold. Try lowering the threshold.")

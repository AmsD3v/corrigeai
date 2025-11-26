# Script to add correction_type to models.py
import sys

# Read the file
with open('src/models.py', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find the line with 'status = Column(String, default="pending")'
# and add correction_type after it
new_lines = []
for i, line in enumerate(lines):
    new_lines.append(line)
    if 'status = Column(String, default="pending")' in line and 'Submission' in ''.join(lines[max(0,i-10):i]):
        # Add correction_type after this line
        indent = line[:len(line) - len(line.lstrip())]
        new_lines.append(f'{indent}correction_type = Column(String, default="advanced")  # "advanced" or "premium"\n')
        print(f"✅ Added correction_type field after line {i+1}")

# Write back
with open('src/models.py', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print("✅ models.py updated successfully!")

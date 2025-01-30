import sys

def retrieve_text(input_text):
    return f"Processed: {input_text}"

if __name__ == "__main__":
    input_text = sys.argv[1]  
    result = retrieve_text(input_text)
    print(result) 
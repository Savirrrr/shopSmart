import spacy
import sys
import sentimental_analysis
import json
import review_classification

nlp = spacy.load("en_core_web_sm")

def analyze_reviews(products_data):
    for product in products_data:
        reviews = product.get("reviews", [])  # Extract reviews
        results = []
        positive_count = 0

        for text in reviews:
            tokens = nlp(text)
            filtered_words = [token.text for token in tokens if not token.is_stop]
            filtered_text = " ".join(filtered_words)  

            sentiment_label = sentimental_analysis.analyze_sentiment(filtered_text)  
            transformer_sentiment = review_classification.classify_review(filtered_text)

            final_sentiment = "Positive" if transformer_sentiment == "Positive" and sentiment_label == "Positive" else "Negative"

            if sentiment_label == "Positive":
                positive_count += 1

            results.append({"review": text, "sentiment": final_sentiment})

        total_reviews = len(reviews)
        positive_percentage = (positive_count / total_reviews) * 100 if total_reviews > 0 else 0

        product["review_analysis"] = {
            "positive_percentage": f"{positive_percentage:.2f}%",
        }

    return products_data

def process_file(file_path):
    try:
        # Open the file and load the reviews
        with open(file_path, 'r') as file:
            data = json.load(file)

        reviews = data.get("reviews", [])
        if not reviews:
            print("No reviews found in the file.")
            return file_path

        # Process reviews and get the sentiment analysis results
        overall_sentiment= analyze_reviews(reviews)

        # Remove reviews from the data and add overall sentiment
        data["reviews"] = []
        data["rating"] = overall_sentiment

        # Save the modified data back to the same file
        with open(file_path, 'w') as file:
            json.dump(data, file, indent=4)

        return file_path

    except Exception as e:
        print(f"Python Error: {str(e)}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    try:
        file_path = sys.argv[1]

        updated_file_path = process_file(file_path)
        print(f"File updated successfully: {updated_file_path}")

    except Exception as e:
        print(f"Python Error: {str(e)}", file=sys.stderr)
        sys.exit(1)
# import spacy
# import sys
# import sentimental_analysis
# import json

# nlp=spacy.load("en_core_web_sm")

# def remove_stop_words(reviews):
#     results = []
#     positive_count=0
    
#     for text in reviews:
#         tokens = nlp(text)
#         filtered_words = [token.text for token in tokens if not token.is_stop]
#         filtered_text = " ".join(filtered_words)  

#         sentiment_label = sentimental_analysis.analyze_sentiment(filtered_text) 
        
#         if sentiment_label == "Positive":
#             positive_count += 1
#         results.append(sentiment_label)

#     total_reviews = len(reviews)
#     positive_percentage = (positive_count / total_reviews) * 100 if total_reviews > 0 else 0

#     overall_sentiment = f"{positive_count}/{total_reviews} reviews positive ({positive_percentage:.2f}%)"

#     return overall_sentiment

# if __name__=="__main__":
#     try:
#         text=sys.argv[1]
#         review_score=remove_stop_words(text)

#         print(json.dumps(review_score))
#     except Exception as e:
#         print(f"Python Error: {str(e)}", file=sys.stderr)
#         sys.exit(1)

import spacy
import sys
import sentimental_analysis
import json

nlp = spacy.load("en_core_web_sm")

def analyze_reviews(reviews):
    results = []
    positive_count = 0

    for text in reviews:
        tokens = nlp(text)
        filtered_words = [token.text for token in tokens if not token.is_stop]
        filtered_text = " ".join(filtered_words)  

        sentiment_label = sentimental_analysis.analyze_sentiment(filtered_text)  

        if sentiment_label == "Positive":
            positive_count += 1

        results.append({"review": text, "sentiment": sentiment_label})

    total_reviews = len(reviews)
    positive_percentage = (positive_count / total_reviews) * 100 if total_reviews > 0 else 0

    overall_sentiment = f"{positive_count}/{total_reviews} reviews positive ({positive_percentage:.2f}%)"

    # Debugging Logs

    # print("\n=== Processed Reviews ===",file=sys.stderr)
    # for result in results:
    #     print(f"Review: {result['review']}\nSentiment: {result['sentiment']}\n",file=sys.stderr)
    # print(f"Overall Sentiment Summary: {overall_sentiment}",file=sys.stderr)
    # print("========================\n",file=sys.stderr)

    return int(positive_percentage)

if __name__ == "__main__":
    try:
        reviews = json.loads(sys.argv[1])  
        processed_reviews = analyze_reviews(reviews)

        # Return JSON result
        print(json.dumps(processed_reviews))

    except Exception as e:
        print(f"Python Error: {str(e)}", file=sys.stderr)
        sys.exit(1)
import spacy
import sys
import sentimental_analysis
nlp=spacy.load("en_core_web_sm")

def remove_stop_words_and_analyze(reviews):
    results = []
    
    for text in reviews:
        tokens = nlp(text)
        filtered_words = [token.text for token in tokens if not token.is_stop]
        filtered_text = " ".join(filtered_words) 

        sentiment = sentimental_analysis(filtered_text)
        results.append(sentiment)

    positive_count = results.count("Positive")
    return positive_count / len(results) if results else 0 

if __name__=="__main__":
    text=sys.argv[1]
    review_score=remove_stop_words(text)
    print(review_score)
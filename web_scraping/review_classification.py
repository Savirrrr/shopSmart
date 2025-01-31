# from transformers import pipeline
# from transformers import pipeline, DebertaV2Tokenizer, DebertaV2ForSequenceClassification
# import torch

# # device = torch.device("cpu")  # Force CPU
# # model = model.to(device)

# model_name = 'microsoft/deberta-v3-large'
# model = DebertaV2ForSequenceClassification.from_pretrained(model_name)
# tokenizer = DebertaV2Tokenizer.from_pretrained(model_name)

# classifier = pipeline('text-classification', model=model, tokenizer=tokenizer)
# model_name = "microsoft/deberta-v3-large"
# classifier = pipeline('text-classification', model=model_name, tokenizer=model_name)


# def classify_review(review):
#     result = classifier(review)
#     if result[0]['label'] == 'POSITIVE':
#         return True
#     else:
#         return False
        
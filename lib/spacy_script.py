import spacy

# Load the Japanese language model
nlp = spacy.load("ja_core_news_md")

def extract_keywords(text):
    doc = nlp(text)
    keywords = [token.text for token in doc if not token.is_stop]
    return keywords
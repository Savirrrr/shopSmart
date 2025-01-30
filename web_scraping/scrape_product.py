import json
import os
import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from PIL import Image
from io import BytesIO
import random
import time

# Set the product URL (For now, using dummy URL)
PRODUCT_URL = "https://www.amazon.com/dp/B09G3HRMVB"

# Setup Chrome options
chrome_options = Options()
chrome_options.add_argument("--headless")  # Run Chrome in headless mode (no UI)
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")

# Initialize WebDriver using WebDriver Manager
service = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service=service, options=chrome_options)

def scrape_product(url):
    driver.get(url)
    time.sleep(3)  # Let the page load

    soup = BeautifulSoup(driver.page_source, "html.parser")

    # Extract product title
    title_element = soup.find("span", {"id": "productTitle"})
    title = title_element.text.strip() if title_element else "Title Not Found"

    # Extract price
    price_element = soup.find("span", {"class": "a-price-whole"})
    price = price_element.text.strip() if price_element else "Price Not Found"

    # Extract product image
    image_element = soup.find("img", {"id": "landingImage"})
    image_url = image_element["src"] if image_element else None

    # Download and save the product image
    image_filename = None
    if image_url:
        image_response = requests.get(image_url)
        if image_response.status_code == 200:
            image_filename = f"product_image.jpg"
            image_path = os.path.join(os.getcwd(), image_filename)
            with open(image_path, "wb") as img_file:
                img_file.write(image_response.content)

    # Extract reviews (random 10)
    review_elements = soup.find_all("span", {"class": "a-size-base review-text review-text-content"})
    reviews = [review.text.strip() for review in review_elements]
    reviews = random.sample(reviews, min(10, len(reviews)))  # Get up to 10 reviews

    # Close WebDriver
    driver.quit()

    # Prepare JSON response
    product_data = {
        "title": title,
        "price": price,
        "image": image_filename if image_filename else "No Image Found",
        "reviews": reviews
    }

    return json.dumps(product_data, indent=4)

if __name__ == "__main__":
    product_json = scrape_product(PRODUCT_URL)
    print(product_json)
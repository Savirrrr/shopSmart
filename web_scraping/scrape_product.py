import json
import random
import time
import requests
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import scrape_flipkart
import scrape_amazon

firefox_options = Options()
firefox_options.add_argument("--headless") 
firefox_options.binary_location = "/opt/homebrew/bin/firefox"  


service = Service("/opt/homebrew/bin/geckodriver")
driver = webdriver.Firefox(service=service, options=firefox_options)


def generate_search_url(product_name, platform):
    """Generate search URLs for Amazon and Flipkart."""
    query = product_name.replace(" ", "+")
    
    if platform.lower() == "amazon":
        return f"https://www.amazon.com/s?k={query}"
    elif platform.lower() == "flipkart":
        return f"https://www.flipkart.com/search?q={query}"
    else:
        return None

def scrape_product(product_name, platform):
    search_url = generate_search_url(product_name, platform)
    if not search_url:
        return json.dumps({"error": "Unsupported platform"}, indent=4)

    # if platform.lower() == "amazon":
    file_path,product_data = scrape_amazon.scrape_amazon_products(search_url)
    # elif platform.lower() == "flipkart":
        # product_data = scrape_flipkart_product(search_url)
    # else:
        # return json.dumps({"error": "Unsupported platform"}, indent=4)

    return [file_path,product_data]

if __name__ == "__main__":
    product_text = input("Enter product name: ")  # Example: "iPhone 13"
    
    print("Amazon Product Details:")
    print(scrape_product(product_text, "amazon"))

    # print("\nFlipkart Product Details:")
    # print(scrape_product(product_text, "flipkart"))

    # Close WebDriver after scraping
    driver.quit()
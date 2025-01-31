import json
import random
import time
import requests
import os
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


firefox_options = Options()
firefox_options.add_argument("--headless") 
firefox_options.binary_location = "/opt/homebrew/bin/firefox"  

service = Service("/opt/homebrew/bin/geckodriver")
driver = webdriver.Firefox(service=service, options=firefox_options)


def scrape_amazon_product(url):
    """Scrape product details from Amazon."""
    driver.get(url)
    time.sleep(3)  # Allow page to load

    soup = BeautifulSoup(driver.page_source, "html.parser")

    # Find the first product link
    first_product = soup.find("a", {"class": "a-link-normal s-no-outline"})
    if first_product:
        product_url = "https://www.amazon.com" + first_product["href"]
        driver.get(product_url)
        time.sleep(3)
        soup = BeautifulSoup(driver.page_source, "html.parser")
    else:
        return {"error": "No products found"}

    # Extract product details
    title_element = soup.find("span", {"id": "productTitle"})
    title = title_element.text.strip() if title_element else "Title Not Found"

    price_element = soup.find("span", {"class": "a-price-whole"})
    price = price_element.text.strip() if price_element else "Price Not Found"

    image_element = soup.find("img", {"id": "landingImage"})
    image_url = image_element["src"] if image_element else "No Image Found"

    review_elements = soup.find_all("span", {"data-hook": "review-body"})
    reviews = [review.text.strip() for review in review_elements[:5]]

    return {
        "title": title.strip() if title else "Title Not Found",
        "price": price.strip() if price else "Price Not Found",
        "image_url": image_element["src"] if image_url else "No Image Found",
        "reviews": reviews if reviews else ["No reviews found"],
    }


def scrape_amazon_products(url, num_products=3):
    """Scrape details of multiple products from an Amazon search page."""
    # driver = webdriver.Chrome() 
    driver.get(url)
    time.sleep(3)  # Allow page to load

    soup = BeautifulSoup(driver.page_source, "html.parser")
    driver.get(url)
    time.sleep(3)  # Allow page to load

    # List to store product details
    products_data = []

    # Loop to scrape multiple products
    for _ in range(num_products):
        soup = BeautifulSoup(driver.page_source, "html.parser")

        # Find all product links on the page
        product_links = soup.find_all("a", {"class": "a-link-normal s-no-outline"})
        if not product_links:
            break  # Stop if no more product links are found

        # Loop through product links and scrape details for each product
        for product_link in product_links:
            product_url = "https://www.amazon.com" + product_link["href"]
            driver.get(product_url)
            time.sleep(3)
            soup = BeautifulSoup(driver.page_source, "html.parser")

            # Extract product details
            title_element = soup.find("span", {"id": "productTitle"})
            title = title_element.text.strip() if title_element else "Title Not Found"

            price_element = soup.find("span", {"class": "a-price-whole"})
            price = price_element.text.strip() if price_element else "Price Not Found"

            image_element = soup.find("img", {"id": "landingImage"})
            image_url = image_element["src"] if image_element else "No Image Found"

            review_elements = soup.find_all("span", {"data-hook": "review-body"})
            reviews = [review.text.strip() for review in review_elements[:5]]

            products_data.append({
                "title": title,
                "price": price,
                "image_url": image_url,
                "reviews": reviews,
                "link":product_url
            })

            if len(products_data) >= num_products:
                break

        driver.back()
        time.sleep(2) 

        if len(products_data) >= num_products:
            break


    i = 1
    while os.path.exists(f"amazon_products_{i}.json"):
        i += 1

    file_path = f"amazon_products_{i}.json"
    with open(file_path, "w") as json_file:
        json.dump(products_data, json_file, indent=4) 

    driver.quit()

    return file_path, products_data

    driver.quit()

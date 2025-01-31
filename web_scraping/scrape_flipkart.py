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


firefox_options = Options()
firefox_options.add_argument("--headless") 
firefox_options.binary_location = "/opt/homebrew/bin/firefox"  


service = Service("/opt/homebrew/bin/geckodriver")
driver = webdriver.Firefox(service=service, options=firefox_options)


def scrape_flipkart_product(url):
    driver.get(url)
    time.sleep(3) 
    print(driver.page_source)
    try:
        first_product =WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, 'your_xpath_here'))
    )
        product_url = "https://www.flipkart.com" + first_product.get_attribute("href")
        driver.get(product_url)
        time.sleep(3)

        soup = BeautifulSoup(driver.page_source, "html.parser")

        title = soup.find("span", {"class": "B_NuCI"})
        price = soup.find("div", {"class": "_30jeq3 _16Jk6d"})
        image = soup.find("img", {"class": "_396cs4 _2amPTt _3qGmMb"})

        return {
           "title": title.strip() if title else "Title Not Found",
            "price": price.text.strip() if price else "Price Not Found",
            "image_url": image["src"] if image else "No Image Found",
        }
    except Exception as e:
        return {"error": f"Flipkart scraping failed: {str(e)}"}

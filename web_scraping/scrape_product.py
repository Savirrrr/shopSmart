import sys
import json
import traceback
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
import scrape_amazon
import urllib.parse
import retreive_reviews

def generate_search_url(product_name, platform):
    """Generate search URLs for Amazon and Flipkart."""
    query = urllib.parse.quote_plus(product_name)

    if platform.lower() == "amazon":
        return f"https://www.amazon.com/s?k={query}"
    elif platform.lower() == "flipkart":
        return f"https://www.flipkart.com/search?q={query}"
    else:
        return None

def scrape_product(product_name, platform):
    try:
        search_url = generate_search_url(product_name, platform)
        if not search_url:
            return {"error": "Unsupported platform"}

        # Configure Firefox options to run headless
        firefox_options = Options()
        firefox_options.add_argument("--headless")
        firefox_options.binary_location = "/opt/homebrew/bin/firefox"  

        service = Service("/opt/homebrew/bin/geckodriver")
        
        try:
            # Use context manager to ensure driver is closed
            with webdriver.Firefox(service=service, options=firefox_options) as driver:
                # Modify scrape_amazon_products to accept driver
                product_data = scrape_amazon.scrape_amazon_products(search_url, driver)
                
                if not product_data:
                    return {"error": "No products found"}

                analyzed_data = retreive_reviews.analyze_reviews(product_data)
                return analyzed_data
        except Exception as driver_error:
            return {"error": f"Driver error: {str(driver_error)}"}
    
    except Exception as e:
        # Capture full traceback for debugging
        error_details = {
            "error": str(e),
            "traceback": traceback.format_exc()
        }
        return error_details

if __name__ == "__main__":
    try:
        # Expect product name as first argument
        product_text = sys.argv[1] if len(sys.argv) > 1 else input("Enter product name: ")
        
        result = scrape_product(product_text, "amazon")
        # Use indent=None to ensure minimal whitespace
        print(json.dumps(result, indent=None))
    except Exception as e:
        # Ensure error is output as valid JSON
        print(json.dumps({"error": str(e), "traceback": traceback.format_exc()}))
        sys.exit(1)
import time
from bs4 import BeautifulSoup

def scrape_amazon_products(url, driver, num_products=5):
    try:
        driver.get(url)
        time.sleep(3)  # Allow page to load
        
        products_data = []
        
        for _ in range(num_products):
            soup = BeautifulSoup(driver.page_source, "html.parser")
            product_links = soup.find_all("a", {"class": "a-link-normal s-no-outline"})
            
            if not product_links:
                break
                
            for product_link in product_links:
                href = product_link["href"]
                product_url = href if href.startswith('https://') else f"https://www.amazon.com{href}"
                
                try:
                    driver.get(product_url)
                    time.sleep(3)
                    soup = BeautifulSoup(driver.page_source, "html.parser")
                    
                    # Extract product details
                    title_element = soup.find("span", {"id": "productTitle"})
                    price_element = soup.find("span", {"class": "a-price-whole"})
                    image_element = soup.find("img", {"id": "landingImage"})
                    review_elements = soup.find_all("span", {"data-hook": "review-body"})
                    
                    products_data.append({
                        "title": title_element.text.strip() if title_element else "Title Not Found",
                        "price": price_element.text.strip() if price_element else "Price Not Found",
                        "image_url": image_element["src"] if image_element else "No Image Found",
                        "reviews": [review.text.strip() for review in review_elements[:5]] or ["No reviews found"],
                        "url": product_url
                    })
                    
                    if len(products_data) >= num_products:
                        return products_data
                    
                except Exception as e:
                    # Log error but continue processing
                    print(f"Error processing product {product_url}: {e}", file=sys.stderr)
                    continue
                
        return products_data
    
    except Exception as e:
        # Ensure any unexpected errors are captured
        return {"error": str(e)}
//Kuzey Cimen - 1803189 - kc18182
package shop;

import java.util.Collection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class Basket {

    HashMap<Product, Integer> items;
    ShopDB db;

    public Basket() {
        db = ShopDB.getSingleton();
        items = new HashMap<Product, Integer>();
    }

    /**
     * @return Collection of shop.Product items that are stored in the basket
     * <p>
     * Each item is a product object - need to be clear about that...
     * <p>
     * When we come to list the shop.Basket contents, it will be much more
     * convenient to have all the product details as items in this way
     * in order to calculate that product totals etc.
     */
    public HashMap<Product, Integer> getItems() {
        return items;
    }

    /**
     * empty the basket - the basket should contain no items after calling this method
     */
    public void clearBasket() {
        items.clear();
    }

    /**
     * Adds an item specified by its product code to the shopping basket
     *
     * @param pid - the product code
     */
    public void addItem(String pid) {

        // need to look the product name up in the
        // database to allow this kind of item adding...

        addItem(db.getProduct(pid));

    }

    public void addItem(Product p) {
        if (p != null) {
            for (Product p2 : getItems().keySet()) {
                if (p2.PID.equals(p.PID)) {
                    int count = items.get(p2);
                    items.remove(p2);
                    items.put(p, count + 1);
                    return;
                }
            }
            items.put(p, 1);
        }
    }

    /**
     * @return the total value of items in the basket in pence
     */
    public int getTotal() {
        int total = 0;
        for (Product item : items.keySet()) {
            total += (item.price * items.get(item));
        }

        return total;
    }

    /**
     * @return the total value of items in the basket as
     * a pounds and pence String with exactly two decimal places - hence
     * suitable for inclusion as a total in a web page
     */
    public String getTotalString() {
        return String.format("%.2f", getTotal() / 100.0);
    }

    public int remove(Product p, int amount) {
        int count = items.get(p);
        items.remove(p);
        if (amount <= 0) {
            return 0;
        } else if (amount < count) {
            items.put(p, count - amount);
            return amount;
        } else {
            return count;
        }
    }
}

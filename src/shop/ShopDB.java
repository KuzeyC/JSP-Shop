//Kuzey Cimen - 1803189 - kc18182
package shop;

import java.sql.*;
import java.util.Collection;
import java.util.LinkedList;
import java.util.Iterator;
import java.util.Map;

public class ShopDB {

    Connection con;
    static int nOrders = 0;
    static ShopDB singleton;

    public ShopDB() {
        try {
            Class.forName("org.hsqldb.jdbc.JDBCDriver");
            System.out.println("Loaded Class");
            con = DriverManager.getConnection("jdbc:hsqldb:file:\\tomcat\\webapps\\ass2\\shopdb", "sa", "");
//            con = DriverManager.getConnection("jdbc:hsqldb:file:C:\\Users\\Kuzey\\Desktop\\Year 2\\CE212\\Assignment 2\\tomcat\\webapps\\ass2\\shopdb", "sa", "");
            System.out.println("Created Connection");
        } catch (Exception e1) {
            System.out.println("Exception: " + e1);
            return;
        }
        System.out.println("");
    }

    public static ShopDB getSingleton() {
        if (singleton == null) {
            singleton = new ShopDB();
        }
        return singleton;
    }

    //Method for getting products.
    public ResultSet getProducts() {
        try {
            System.out.println("Created statement");
            //Prepared Statement for getting products.
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Product");
            System.out.println("Returning result set...");
            return ps.executeQuery();
        }
        catch(Exception e) {
            System.out.println( "Exception in getProducts(): " + e );
            return null;
        }
    }

    //Method for getting all of the products.
    public Collection<Product> getAllProducts() {
        try {
            //Prepared Statement for getting all of the products.
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Product");
            return getProductCollection(ps);
        }
        catch(Exception e) {
            return null;
        }
    }

    //Method for getting a single product.
    public Product getProduct(String pid) {
        try {
            // re-use the getProductCollection method
            // even though we only expect to get a single shop.Product Object
            //Prepared Statement for getting all of the products that have the same PID as the input.
            PreparedStatement ps = con.prepareStatement("SELECT * from Product WHERE PID = ?");
            ps.setString(1, pid);
            Collection<Product> c = getProductCollection( ps );
            Iterator<Product> i = c.iterator();
            return i.next();
        }
        catch(Exception e) {
            // unable to find the product matching that pid
            return null;
        }
    }

    //Method for returning the collection of products from the results set input.
    public Collection<Product> getProductCollection(PreparedStatement ps) {
        LinkedList<Product> list = new LinkedList<>();
        try {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() ) {
                Product product = new Product(
                        rs.getString("PID"),
                        rs.getString("Artist"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getInt("price"),
                        rs.getString("thumbnail"),
                        rs.getString("fullimage")
                );
                list.add( product );
            }
            return list;
        }
        catch(Exception e) {
            System.out.println( "Exception in getProducts(): " + e );
            return null;
        }
    }

    public void order(Basket basket, String customer) {
        try {
            // create a unique order id
            String orderId = System.currentTimeMillis() + ":" + nOrders++;

            // iterate over the basket of contents ...
            Iterator i = basket.getItems().entrySet().iterator();
            while (i.hasNext()) {
                Map.Entry product = (Map.Entry) i.next();
                Product p = (Product) product.getKey();
                Integer count = (Integer) product.getValue();
                // and place the order for each one
                order( con, p, orderId, customer, count);
            }
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

    private void order(Connection con, Product p, String orderID, String customer, Integer c) throws Exception {
        //Prepared Statement for ordering the basket.
        PreparedStatement ps = con.prepareStatement("INSERT INTO Orders VALUES(?, ?, ?, ?, ?)");
        ps.setString(1, p.PID);
        ps.setString(2, orderID);
        ps.setString(3, null);
        ps.setDouble(4, c);
        ps.setDouble(5, p.price);
        int a = ps.executeUpdate();
        System.out.println(a + " updated.");
    }
}

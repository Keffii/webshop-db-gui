package webshop_db;

import javax.swing.*;
import java.awt.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class SqlQueriesWithSwing {

    private JTextArea textArea;
    private JLabel statusLabel;
    private JLabel buttonDescriptionLabel; // New label for button descriptions
    private String fontName = "Arial"; // Arial font
    private String sqlFont = "MONOSPACED";
    private void prepareTextAreaForTable() {
        textArea.setFont(new Font(Font.MONOSPACED, Font.PLAIN, 14)); // or use your sqlFont if it's monospaced
        textArea.setLineWrap(false);
        textArea.setWrapStyleWord(false);
    }

    public void DB() {
        JFrame frame = new JFrame("Queries");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(800, 700);
        frame.setLocationRelativeTo(null);

        // MainPanel
        JPanel mainPanel = new JPanel(new BorderLayout(10, 10));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(15, 15, 15, 15));

        // North panel for title and buttons
        JPanel northPanel = new JPanel();
        northPanel.setLayout(new BoxLayout(northPanel, BoxLayout.Y_AXIS));
        JPanel titlePanel = new JPanel(new BorderLayout());
        JLabel titleLabel = new JLabel("Sql queries", SwingConstants.CENTER);
        titleLabel.setFont(new Font(fontName, Font.BOLD, 18));
        titlePanel.add(titleLabel, BorderLayout.CENTER);
        northPanel.add(titlePanel);

        // TopPanel for buttons and descriptions
        JPanel topPanel = new JPanel(new BorderLayout());

        // Buttons
        JPanel buttonPanel = new JPanel();
        JButton button1 = new JButton("Query 1");
        JButton button2 = new JButton("Query 2");
        JButton button3 = new JButton("Query 3");
        JButton button4 = new JButton("Query 4");
        JButton button5 = new JButton("Query 5");

        buttonPanel.add(button1);
        buttonPanel.add(button2);
        buttonPanel.add(button3);
        buttonPanel.add(button4);
        buttonPanel.add(button5);

        // Button labels
        buttonDescriptionLabel = new JLabel("Click a button to see query description", SwingConstants.CENTER);
        buttonDescriptionLabel.setFont(new Font(fontName, Font.BOLD, 18));
        buttonDescriptionLabel.setBorder(BorderFactory.createEmptyBorder(5, 0, 5, 0));

        // Buttons and description for topPanel
        topPanel.add(buttonPanel, BorderLayout.NORTH);
        topPanel.add(buttonDescriptionLabel, BorderLayout.SOUTH);
        northPanel.add(topPanel);

        // Lägg northPanel i huvudpanelen
        mainPanel.add(northPanel, BorderLayout.NORTH);

        // TextArea
        textArea = new JTextArea();
        textArea.setEditable(false);
        textArea.setFont(new Font(fontName, Font.PLAIN, 14));
        textArea.setBorder(BorderFactory.createLineBorder(Color.GRAY, 1));
        JScrollPane scrollPane = new JScrollPane(textArea);
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        // Statusfield for error handling
        statusLabel = new JLabel(" ");
        statusLabel.setFont(new Font("Arial", Font.BOLD, 12));
        statusLabel.setForeground(Color.RED);
        mainPanel.add(statusLabel, BorderLayout.SOUTH);

        // ActionListeners
        button1.addActionListener(e -> {
            runQuery1();
            buttonDescriptionLabel.setText("Query 1: Customers who bought black SweetPants pants in size 38");
        });
        button2.addActionListener(e -> {
            runQuery2();
            buttonDescriptionLabel.setText("Query 2: Product count per category, ordered by amount");
        });
        button3.addActionListener(e -> {
            runQuery3();
            buttonDescriptionLabel.setText("Query 3: Total order value per city where the total order value exceeds 1000 SEK");
        });
        button4.addActionListener(e -> {
            runQuery4();
            buttonDescriptionLabel.setText("Query 4: Top 5 of the most sold products");
        });
        button5.addActionListener(e -> {
            runQuery5();
            buttonDescriptionLabel.setText("Query 5: Which month had the most sales?");
        });

        frame.setContentPane(mainPanel);
        frame.setVisible(true);
    }


    private Connection getConnection() throws SQLException, IOException {
        Properties p = new Properties();
        p.load(new FileInputStream("src/webshop_db/settings.properties"));
        return DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"));
    }

    private void runQuery1() {
        prepareTextAreaForTable();
        textArea.setText("");
        textArea.append(String.format("Customer name: \n"));
        textArea.append("--------------\n");
        try (Connection con = getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("""
                select distinct customer.name as customer_name
                from customer
                inner join orders on customer.customer_id = orders.customer_id
                inner join order_item on orders.order_id = order_item.order_id
                inner join product on order_item.product_id = product.product_id
                inner join brand on product.brand_id = brand.brand_id
                where brand.brand_name = 'SweetPants'
                and product.color = 'Black'
                and product.size = '38'
                and product.product_name like '%pants%';
             """)) {

            while (rs.next()) {
                String customerName = rs.getString("customer_name");
                textArea.append(customerName + "\n");
            }

        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("A error occured: " + e.getMessage());
        }
    }

    private void runQuery2() {
        prepareTextAreaForTable();
        textArea.setText("");
        textArea.append(String.format("%-20s | %s%n", "Category", "Product Amount"));
        textArea.append("---------------------|---------------\n");
        try (Connection con = getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("""
                select category.category_name, count(product_category.product_id) as product_amount
                from category
                left join product_category on category.category_id = product_category.category_id
                group by category.category_id, category.category_name
                order by product_amount;
             """)) {

            while (rs.next()) {
                String category_name = rs.getString("category_name");
                int product_amount = rs.getInt("product_amount");
                textArea.append(String.format("%-20s | %d%n", category_name, product_amount));
            }
        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("A error occured: " + e.getMessage());
        }
    }

    private void runQuery3() {
        prepareTextAreaForTable();
        textArea.setText("");
        textArea.append(String.format("%-15s | %s\n", "City", "Total order value"));
        textArea.append("----------------|---------------\n");
        try (Connection con = getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("""
                select customer.city as City, sum(product.stock_price * order_item.quantity) as Total_order_value
                from customer
                inner join orders on customer.customer_id = orders.customer_id
                inner join order_item on orders.order_id = order_item.order_id \s
                inner join product on order_item.product_id = product.product_id
                group by customer.city
                having total_order_value > 1000
                order by total_order_value desc;
             """)) {

            while (rs.next()) {
                String city = rs.getString("city");
                double total_order_value = rs.getDouble("total_order_value");
                textArea.append(String.format("%-15s | %.2f\n", city, total_order_value));
            }
        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("A error occured: " + e.getMessage());
        }
    }

    private void runQuery4() {
        prepareTextAreaForTable();
        textArea.setText("");
        textArea.append(String.format("%-15s | %-14s | %-14s \n", "Product Name", "BrandName", "Top 5 Orders"));
        textArea.append("----------------|----------------|-------------\n");
        try (Connection con = getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("""

                select\s
                product.product_name,
                brand.brand_name,
                sum(order_item.quantity) as top_5
                from order_item
                inner join orders on order_item.order_id = orders.order_id
                inner join customer on orders.customer_id = customer.customer_id
                inner join product on order_item.product_id = product.product_id
                inner join brand on product.brand_id = brand.brand_id
                group by product.product_id, product.product_name, brand.brand_name
                order by top_5 desc
                limit 5;

             """)) {

            while (rs.next()) {
                String product_name = rs.getString("product_name");
                String brand_name = rs.getString("brand_name");
                int top_5 = rs.getInt("top_5");
                textArea.append(String.format("%-15s | %-15s| %d\n", product_name, brand_name, top_5));
            }
        } catch (Exception e) {
            e.printStackTrace();
            statusLabel.setText("A error occured: " + e.getMessage());
        }
    }

    private void runQuery5() {
            textArea.setText("");
            textArea.setFont(new Font(sqlFont, Font.PLAIN, 14));
            textArea.append(String.format("%-15s | %s\n", "Order Month", "Total sales"));
            textArea.append("----------------|------------\n");

            try (Connection con = getConnection();
                 Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("""
                select date_format(orders.order_date, '%Y-%M') as order_month,
                    sum(order_item.quantity * product.stock_price) as total_sales
                from orders
                join order_item on orders.order_id = order_item.order_id
                join product on order_item.product_id = product.product_id
                group by order_month
                order by total_sales desc
             """)) {

                while (rs.next()) {
                    String order_month = rs.getString("order_month");
                    double total_sales = rs.getDouble("total_sales");
                    textArea.append(String.format("%-15s | %.2f\n", order_month, total_sales));
                }
            } catch (Exception e) {
                e.printStackTrace();
                statusLabel.setText("A error occured: " + e.getMessage());
            }
        }
    }

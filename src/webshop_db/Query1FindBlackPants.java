package webshop_db;

import javax.swing.*;
import java.awt.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class Query1FindBlackPants {

    public void DB() throws SQLException, IOException {
        // Skapa ett fönster
        JFrame frame = new JFrame("Queries");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 350);
        frame.setLocationRelativeTo(null); // Centrera fönstret

        // Huvudpanel med padding
        JPanel mainPanel = new JPanel(new BorderLayout(10, 10));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(15, 15, 15, 15));

        // Titel
        JLabel titleLabel = new JLabel("Query 1: Kunder som har köpt svarta byxor", SwingConstants.CENTER);
        titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 18));
        mainPanel.add(titleLabel, BorderLayout.NORTH);

        // Textområde där vi skriver ut resultatet
        JTextArea textArea = new JTextArea();
        textArea.setEditable(false); // användaren ska inte kunna ändra
        textArea.setFont(new Font("Segoe UI", Font.PLAIN, 14));
        textArea.setBorder(BorderFactory.createLineBorder(Color.GRAY, 1));
        JScrollPane scrollPane = new JScrollPane(textArea);
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        // Statusrad för felmeddelanden
        JLabel statusLabel = new JLabel(" ");
        statusLabel.setFont(new Font("Segoe UI", Font.ITALIC, 12));
        statusLabel.setForeground(Color.RED);
        mainPanel.add(statusLabel, BorderLayout.SOUTH);

        frame.setContentPane(mainPanel);
        frame.setVisible(true);

        // Ladda inställningar
        Properties p = new Properties();
        p.load(new FileInputStream("src/webshop_db/settings.properties"));

        try (Connection con = DriverManager.getConnection(
                p.getProperty("connectionString"),
                p.getProperty("name"),
                p.getProperty("password"))) {

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("""
                select distinct customer.name
                from customer
                inner join orders on customer.customer_id = orders.customer_id
                inner join order_item on orders.order_id = order_item.order_id
                inner join product on order_item.product_id = product.product_id
                inner join brand on product.brand_id = brand.brand_id
                where brand.brand_name = 'SweetPants'
                and product.color = 'Svart'
                and product.size = '38'
                and product.product_name like '%byxor%'
            """);

            while (rs.next()) {
                String customerName = rs.getString("name");
                textArea.append(customerName + "\n"); // skriv rad för rad
            }
        } catch (SQLException e) {
            e.printStackTrace();
            statusLabel.setText("Ett fel uppstod: " + e.getMessage());
        }
    }
}

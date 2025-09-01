package webshop_db;

import java.io.IOException;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) throws Exception {
        Query1FindBlackPants db = new Query1FindBlackPants();
        db.DB(); // anropa databaskoden
    }
}

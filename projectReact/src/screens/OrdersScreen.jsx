import React, { useContext, useEffect } from "react";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemText from "@mui/material/ListItemText";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import Avatar from "@mui/material/Avatar";
import BookmarkBorderIcon from "@mui/icons-material/BookmarkBorder";
import ListItemButton from "@mui/material/ListItemButton";
import { fetchOrders, OrdersContext } from "../context/OrderContext";
import styles from "../styles/OrdersScreen.module.css";

const OrdersScreen = () => {
  const { orders, setOrders } = useContext(OrdersContext);
  useEffect(() => {
    fetchOrders().then(res => setOrders(res?.data));
  }, []);

  return (
    <div className={styles.page}>
      <List className={styles.list}>
        {orders?.map(order => (
          <ListItem key={order.ID}>
            <ListItemButton>
              <ListItemAvatar>
                <Avatar>
                  <BookmarkBorderIcon />
                </Avatar>
              </ListItemAvatar>
              <ListItemText
                primary={`Created: ${order.CreatedAt.substring(0, 10)} 
                ${order.CreatedAt.substring(11, 19)}`}
                secondary={`Payment method: ${order.PaymentMethod}`}
              />
              <h3>{order.OrderPrice} zł</h3>
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </div>
  );
};

export default OrdersScreen;

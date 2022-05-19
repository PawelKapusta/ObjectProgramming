import React from "react";
import styles from "../styles/PaymentScreen.module.css";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemButton from "@mui/material/ListItemButton";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import Avatar from "@mui/material/Avatar";
import BookmarkBorderIcon from "@mui/icons-material/BookmarkBorder";
import ListItemText from "@mui/material/ListItemText";
import {createOrder} from "../context/BasketContext";

const PaymentScreen = () => {
  const AvailablePaymentMethods = [
    {
      ID: 1,
      Name: "Klarna"
    },
    {
      ID: 2,
      Name: "Strips"
    },
    {
      ID: 3,
      Name: "PayPal"
    },
    {
      ID: 4,
      Name: "Credit Card"
    },
  ];

  const handlePaymentMethodClick = async (id) => {
    const payment  = AvailablePaymentMethods.filter(element => element.ID === id)[0];
    const {Name} = payment;
    const order = {OrderPrice: 1000.00, PaymentMethod: Name };
    await createOrder(order);
  }

  return (
   <div className={styles.page}>
     <div className={styles.header}>
     <h1 >Choose payment method and complete the order!</h1>
     <List className={styles.list}>
       {AvailablePaymentMethods?.map(payment => (
        <ListItem key={payment.ID}>
          <ListItemButton onClick={() => handlePaymentMethodClick(payment.ID)}>
            <ListItemAvatar>
              <Avatar>
                <BookmarkBorderIcon />
              </Avatar>
            </ListItemAvatar>
            <ListItemText
             primary={`Created: ${payment.Name}`}
            />
          </ListItemButton>
        </ListItem>
       ))}
     </List>
     </div>
   </div>
  )
};

export default PaymentScreen;

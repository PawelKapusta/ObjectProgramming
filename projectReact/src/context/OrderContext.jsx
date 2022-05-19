import React, { useState } from "react";
import http from "../api/axios";

const defaultState = {
  orders: [],
  setOrders: () => {},
  getById: () => undefined,
};

export const OrdersContext = React.createContext(defaultState);

export const fetchOrders = async () => {
  return await http.get(`/orders`);
};

export const fetchOrderById = id => http.get(`/orders/${id}`);

export const OrdersContextProvider = ({ children }) => {
  const [orders, setOrders] = useState([]);

  const providerValue = {
    orders,
    setOrders,
    getById: id => orders.find(p => p.id === id),
  };

  return <OrdersContext.Provider value={providerValue}>{children}</OrdersContext.Provider>;
};


export type CartItem = {
   id: string;
   imgUrl: string;
   name: string;
   price: number;
   count: number;
}

export type Item = Omit<CartItem, "count">
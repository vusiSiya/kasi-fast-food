
export type CartItem = {
   id: string;
   ImgUrl: string;
   name: string;
   price: number;
   count: number;
}

export type Item = Omit<CartItem, "count">
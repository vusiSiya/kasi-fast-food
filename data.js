

const data = {
	items: [{
		id: 1,
		imgUrl: "./Images/kota.jpg",
		name: "Kota",
		price: 22,
		count: 5
	}, {
		id: 2,
		imgUrl: "./Images/burger.jpg",
		name: "Burger",
		price: 35,
		count: 5
	}, {
		id: 3,
		imgUrl: "./Images/fried-chips.jpg",
		name: "Fried Chips",
		price: 22,
		count: 5
	}, {
		id: 4,
		imgUrl: "./Images/magwinya.jpg",
		name: "Magwinya",
		price: 15,
		count: 5
	}, {
		id: 5,
		imgUrl: "./Images/hot-dogs.jpg",
		name: "Hot Dogs",
		price: 15,
		count: 0
	}, {
		id: 6,
		imgUrl: "./Images/shrimp.jpg",
		name: "Fried Shrimp",
		price: 25,
		count: 0
	}, {
		id: 7,
		imgUrl: "./Images/pap-and-wors.jpg",
		name: "Pap and Boerwors",
		price: 40,
		count: 5
	}]
};

import { nanoid } from "nanoid";

const getAllItems =()=>data.items;
const getBoughtItems = ()=>data.items.filter(item=>item.count);
const getTotalCount = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.count), 0);
const getTotalPrice = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.price * item.count), 0);

const removeItem = (itemId)=>{
	let item = getBoughtItems().find(item=>item.id === itemId);
	item.count = 0;
	render();
}

export {data, getAllItems, getBoughtItems, getTotalPrice,getTotalCount, removeItem}
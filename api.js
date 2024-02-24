import {data} from "./data"

const getAllItems =()=>data.items;
const getBoughtItems = ()=>data.items.filter(item=>item.count);
const getTotalCount = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.count), 0);
const getTotalPrice = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.price * item.count), 0);

const removeItem = (itemId)=>{
	let item = getBoughtItems().find(item=>item.id === itemId);
	item.count = 0;
	render();
}

export {getAllItems, getBoughtItems, getTotalPrice,getTotalCount, removeItem}
//@ts-nocheck
//import { fileURLToPath } from "url";
import {data} from "./data"

const getAllItems =()=>data.items;

const getBoughtItems = ()=>data.items.filter(item=>item.count);
const getTotalCount = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.count), 0);
const getTotalPrice = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.price * item.count), 0);

const removeItem = (itemId)=>{
	let item = getBoughtItems().find(item=>item.id === itemId);
	item.count = 0;
}

function getImage(filePath) {
	const allImageUrls = getAllItems().map(item => item.imgUrl)
	const getUrl =(filePath)=> allImageUrls.find(imageUrl => imageUrl === filePath)
	const images = {
		"burger": {img:async ()=> await import("./Images/burger.jpg")},
		"kota": {img: async()=> await import("./Images/kota.jpg")}
	}

	const fetchImage = (filePath, images)=>{
		//const arr = filePath.split()
		switch (filePath) {
			case "burger":
				return images.burger.img()
				break;
			default:
				break;
		}
	}

	return(fetchImage(filePath, images))

}

export const images = {
	"burger": {img:()=> import("./Images/burger.jpg")},
	"kota": {img: ()=> import("./Images/kota.jpg")},
	"fried_chips": {img: ()=> import("./Images/fried-chips.jpg")}
}

const secondGetImage = (path)=>{
	console.log(path)
	//import image from path
	//return image
}

export {getAllItems, getBoughtItems, getTotalPrice, getTotalCount, getImage, secondGetImage, removeItem}

import {data} from "./data"

import { initializeApp } from "firebase/app";
import {
	getFirestore,
	collection,
	getDocs,
	getDoc,
	doc,
	query
} from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyBsFammEWm4YtfZfZ-Xy2Gy1f1AE4fp720",
  authDomain: "imba-menu-app.firebaseapp.com",
  projectId: "imba-menu-app",
  storageBucket: "imba-menu-app.appspot.com",
  messagingSenderId: "911793695166",
  appId: "1:911793695166:web:fdbe46a00ce94a2a6931ef"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);


const itemsCollectionRef = collection(db,"items")

const getAllItems = async ()=>{

	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc =>{
		return {...doc.data(), id: doc.id}
	});
	return dataArray;
}

const getBoughtItems = ()=>data.items.filter(item=>item.count);

const getSingleItem = async (itemId)=>{
	const docRef = doc(db, "items", itemId.toString());
	const itemSnapShot = await getDoc(docRef);
	return {...itemSnapShot.data(), id: itemSnapShot.id};
}

export const saveToLocalStorage = (key="",data)=>localStorage.setItem(key,data)

const getTotalCount = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.count), 0);
const getTotalPrice = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.price * item.count), 0);


const removeItem = (itemId)=>{
	let item = getBoughtItems().find(item=>item.id === itemId);
	item.count = 0;
}

export {getAllItems,getSingleItem, getBoughtItems, getTotalPrice, getTotalCount, removeItem}
//@ts-nocheck
//import { fileURLToPath } from "url";
//import { URL } from "url";
import {data} from "./data"

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore, collection, getDocs, addDoc, query, getDocsFromServer } from "firebase/firestore";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
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
const getTotalCount = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.count), 0);
const getTotalPrice = ()=>getBoughtItems().reduce((sum,item)=>(sum + item.price * item.count), 0);

const removeItem = (itemId)=>{
	let item = getBoughtItems().find(item=>item.id === itemId);
	item.count = 0;
}

export {getAllItems, getBoughtItems, getTotalPrice, getTotalCount, removeItem}
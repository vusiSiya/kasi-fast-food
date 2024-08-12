
// firestore
import {
	getFirestore,
	collection,
	getDocs,
	getDoc,
	doc,
	deleteDoc, 
	addDoc,
	setDoc,
	updateDoc, 
	query,
	where
} from "firebase/firestore";

import {nanoid} from 'nanoid'
import type {Item, CartItem } from "./types";
import {app, auth } from "./auth";

// initialisation
const db = getFirestore(app);
const itemsCollectionRef = collection(db,"items");
const cartItemsCollectionRef = collection(db, "items-on-cart")


// functions, --reading data--
export async function getAllItems(): Promise<Item[] | any[]>{
	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc =>{
		return {
			...doc.data(),
			id: doc.id + nanoid(10)
		}
	});
	return dataArray;
}

export async function getSingleItem(id: string): Promise<Item | Partial<Item>>{
	const generalItemsRef = doc(db, "items", id[0].toString());
	const itemSnapShot = await getDoc(generalItemsRef);
	return {
		...itemSnapShot.data(),
		id: id
	}
}

export async function getSingleCartItem(id:string): Promise<CartItem | null>{
	const cartItems: CartItem[] = await get(getCartItems);
	return cartItems ? cartItems.find(item=> item.id[0] === id[0]) : null
}

export async function getCartItems(): Promise<CartItem[] | any[]>{
	const userId = auth.currentUser?.uid
	const q = query(cartItemsCollectionRef, where("uid", "==", userId))
	const querySnapshot = await getDocs(q);
	const cartItems = querySnapshot?.docs.map(doc =>{
		return {
			...doc.data()
		}
	})
	return cartItems
}

export async function getTotalCount (): Promise<number>{
	const cartItems: CartItem[] = await get(getCartItems);
	const count = cartItems?.reduce((sum,item)=>sum + item.count, 0);
	return count || 0
}

export async function getTotalPrice (): Promise<number>{
	const cartItems:CartItem[] = await get(getCartItems);
	const totalPrice = cartItems.reduce((sum, item)=>{
		return sum + item.price * item.count
	}, 0);
	return totalPrice || 0
}


// functions, --writing--
export async function addItemToCart(id: string){
	try {
		const item = await getSingleItem(id);
		const user_uid = auth.currentUser.uid
		await setDoc(doc(db, "items-on-cart", id),{
			...item,
			count: 1,
			uid: user_uid
		})
		
	} catch (err) {
		console.error(err.message)
	}
}

export async function updateItemCount(id: string, count: number){
	try {
		const itemRef = doc(db, "items-on-cart", id)
		await updateDoc(itemRef, {
			count: Number(count)
		})
	} catch (err) {
		console.error(err.message)
	}
}

export async function removeItem(id: string){
	try {
		const itemRef = doc(db, "items-on-cart", id)
		await deleteDoc(itemRef)
	} catch (err) {
		console.error(err.message)
	}
}


export function checkAuthState(){
	const user_uid = localStorage.getItem("user-uid")
	return user_uid ? true : false
}

export async function get<T>( func: Function): Promise<T>{
	try {
		return await func()
	} catch (err) {
		console.error(err.message)
		return null
	}
}
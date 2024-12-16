
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
	where,
} from "firebase/firestore"

import {nanoid} from 'nanoid'
import type {Item, CartItem } from "./types"
import {app, auth } from "./auth"

// initialisation
const db = getFirestore(app)
const itemsCollectionRef = collection(db,"items")
const cartItemsCollectionRef = collection(db, "items-on-cart")


// functions, --reading data--
export async function getAllItems(): Promise<Item[] | any[]> {
	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc => {
		return {
			...doc.data(),
			id: doc.id + nanoid(10)
		}
	})
	return dataArray
}

export async function getSingleItem(id: string): Promise<Item | Partial<Item>> {
	const itemRef = doc(db, "items", id[0].toString())
	const snapShot = await getDoc(itemRef)
	return {
		...snapShot.data(),
		id: id
	}
}

export async function getSingleCartItem(id: string): Promise<CartItem> {
	const cartItems = await _catch<CartItem[]>(getCartItems)
	const item = cartItems.find(item => item.id[0] === id[0])
	return item || null
}

export async function getCartItems() : Promise<CartItem[] | Partial<CartItem>[]> {
	const userId = auth.currentUser?.uid
	const q = query(cartItemsCollectionRef, where("uid", "==", userId))
	const querySnapshot = await getDocs(q)
	const cartItems = querySnapshot?.docs.map(doc => {
		return {
			...doc.data()
		}
	})
	return cartItems
}

export async function getTotalCount(): Promise<number> {
	const items = await _catch<CartItem[]>(getCartItems)
	const count = items?.reduce((sum, item)=> sum + item.count, 0)
	return count || 0
}

export async function getTotalPrice(): Promise<number> {
	const items = await _catch<CartItem[]>(getCartItems)
	const totalPrice = items?.reduce((sum, item)=> {
		return sum + item.price * item.count
	}, 0)
	return totalPrice || 0
}


// functions, --writing--
export async function addItemToCart(id: string): Promise<void> {
	const item = await getSingleItem(id)
	const user_uid = auth.currentUser?.uid || null

	if(!user_uid) return

	await setDoc(doc(db, "items-on-cart", id), {
			...item,
			count: 1,
			uid: user_uid
		}
	)
}

export async function updateItemCount(id: string, count: number): Promise<void> {
	const itemRef = doc(db, "items-on-cart", id)
	await updateDoc(itemRef, {
		count: Number(count)
	})
}

export async function removeItem(id: string): Promise<void> {
	const itemRef = doc(db, "items-on-cart", id)
	await deleteDoc(itemRef)
}

// utils
export async function _catch<T>( func: Function): Promise<T | null> {
	try {
		const data = await func()
		return data
	} 
	catch (err) {
		console.log(err.message)
		return null
	}
}

export function redirect(path: string): void {
	const url = new URL(path, window.location.origin)
	const newMetaTag = document.createElement("meta")
	newMetaTag.httpEquiv = "Refresh"
	newMetaTag.content=`0; URL=${url.href}`
	document.head.append(newMetaTag)
}
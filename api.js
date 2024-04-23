
import {data} from "./data"

import { initializeApp } from "firebase/app";

// firestore
import {
	getFirestore,
	collection,
	getDocs,
	getDoc,
	doc,
	setDoc,
	addDoc,
	updateDoc, 
	query,
	where
} from "firebase/firestore";

// authentication
import {
	getAuth,
	createUserWithEmailAndPassword,
	signInWithPopup,
	GoogleAuthProvider,
	signInWithEmailAndPassword,
	onAuthStateChanged, 
	signOut
} from "firebase/auth";


const firebaseConfig = {
  apiKey: "AIzaSyBsFammEWm4YtfZfZ-Xy2Gy1f1AE4fp720",
  authDomain: "imba-menu-app.firebaseapp.com",
  projectId: "imba-menu-app",
  storageBucket: "imba-menu-app.appspot.com",
  messagingSenderId: "911793695166",
  appId: "1:911793695166:web:fdbe46a00ce94a2a6931ef"
};

//initialisation
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = getAuth(app)
const provider = new GoogleAuthProvider()

const itemsCollectionRef = collection(db,"items");
const cartItemsCollection = collection(db, "items-on-cart")

export const user = auth.currentUser

// functions
export const getAllItems = async ()=>{
	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc =>{
		return {...doc.data(), id: doc.id}
	});
	return dataArray;
}


export const getSingleItem = async (itemId)=>{
	const cartItems = await getCartItems();
	const item = cartItems.find(item=> item.id === Number(itemId))
	if (item != null) {
		return item
	}
	else {
		const generalItemsRef = doc(db, "items", itemId.toString());
		const itemSnapShot = await getDoc(generalItemsRef);
		return {
			...itemSnapShot.data(),
			id: itemSnapShot.id
		};
	}
}


export const addItemToCart = async (itemData)=>{
	const itemRef = doc(db, "items-on-cart", itemData.id.toString());
	try {
		await setDoc(itemRef, {
			...itemData,
			count: Number(1),
			id: Number(itemData.id),
			uid: auth.currentUser.uid
		});
		
	} catch (err) {
		console.error(err.message)
	}
}

export const updateItemCount= async (itemId, itemCount)=>{
	const itemRef = doc(db, "items-on-cart", itemId.toString());
	await updateDoc(itemRef, {
		count: Number(itemCount)
	});
}

export const removeItem = async (itemId)=>{
	const itemRef = doc(db, "items-on-cart", itemId.toString());
	await updateDoc(itemRef, {
		count: Number(0)
	});
}

export const getCartItems = async()=>{
	try{
		const cartItemsCollectionRef = collection(db,"items-on-cart");

		const userId = auth.currentUser?.uid || localStorage.getItem("user-uid");
		const q = query(cartItemsCollectionRef, where("uid", "==", userId))

		const querySnapshot = await getDocs(q);
		const cartItems = querySnapshot?.docs.map(doc =>{
			return {
				...doc.data()
			}
		});
		//console.log(cartItems)
		return cartItems
	}
	catch(err){
		console.log(err.message);
		return null
	}
};


export const getTotalCount = async()=>{
	const cartItems = await getCartItems();
	const count = cartItems?.reduce((sum,item)=>(sum + item.count), 0);
	return count || 0
}

export const getTotalPrice = async()=>{
	const cartItems = await getCartItems();
	const totalPrice = cartItems?.reduce((sum,item)=>(sum + item.price * item.count), 0);
	return totalPrice || 0
}


// auth
let loggedInState
onAuthStateChanged(auth, (user) => {
	if (user) {
	  const uid = user.uid;
	  localStorage.setItem("user-uid", uid)
	  console.log(user.emailVerified)
	  //alert("'logged in")
	  loggedInState = true
	} else {
	
		localStorage.removeItem("user-uid");
		loggedInState = false
	  //alert("logged out")
	}
  });

export const getAuthState = ()=>{
	return loggedInState
}


export const authCreateAccountWithEmail = async (email, password)=>{
	try{
		const userCredential = await createUserWithEmailAndPassword(auth, email, password)
		const user = userCredential.user;
		alert("account successfully created!");
	}
	catch(error){
		const errorCode = error.code;
		const errorMessage = error.message;
		console.error(error.message)
		alert(`${errorMessage}`) 
	}
}


export const signInWithEmail = async (email, password)=>{
	// do I need to recive an isloggedIn boolean parameter? to return ?
	try{
		const userCredential = await signInWithEmailAndPassword(auth, email, password)
		const user = userCredential.user;
		return true
	}
	catch(error){
		const errorCode = error.code;
		const errorMessage = error.message;
		console.error(error.message)
		return false
	}
}


export const authSignInWithGoogle= async()=> {
    try{
        const result = await signInWithPopup(auth, provider)
		const user = result.user
        alert("Signed in with Google")
		return true
    }
    catch(error){
		const errorCode = error.code;
		const errorMessage = error.message;
        console.log(error.message)
		return false
    }
}

export const authSignOut= async()=>{
	try{
		await signOut(auth)
		return false
	}
	catch(error){
        console.error(error.message)
	}
}

/* To dos
 * create logInWithGooge UI and modify login-page
 * find a way to access the items-on-cart Collection from Firebase
 * conditionally render the pages( cart-items and item-detail ??), depending on whether user is signed in or not
 * add a testUser or anonymousUser to my users on Firebase.
 * fetch images from Github repo instead

*/



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
	updateDoc 
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


// functions
export const getAllItems = async ()=>{
	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc =>{
		return {...doc.data(), id: doc.id}
	});
	return dataArray;
}


export const getSingleItem = async (itemId)=>{
	
	const cartItemRef = doc(db, "items-on-cart", itemId.toString());
	const generalItemRef = doc(db, "items", itemId.toString());

	const docRef = cartItemRef || generalItemRef;
	const itemSnapShot = await getDoc(docRef);
	return {
		...itemSnapShot.data(),
		id: itemSnapShot.id
	};
}


export const removeItem = async (itemId)=>{
	//find item with id === itemId
	//write to the database, that the item.count is now zero.
	const itemRef = doc(db, "items-on-cart", itemId.toString());
	await updateDoc(itemRef, {
		count: 0
	});
}

export const addItemToCart = async (itemData, itemCount)=>{
	const itemRef = doc(db, "items-on-cart", itemData.id.toString());
	await setDoc(itemRef, {
		...itemData,
		count: itemCount
	});
}

export const updateItemCount= async (itemId, itemCount)=>{
	const itemRef = doc(db, "items-on-cart", itemId.toString());
	await updateDoc(itemRef, {
		count: itemCount
	});
}

export const getCartItems = async()=>{

	const cartItemsCollectionRef = collection(db,"items-on-cart");
	const querySnapshot = await getDocs(cartItemsCollectionRef);
	const cartItems = await querySnapshot?.docs.map(doc =>{
		return {
			...doc.data()
		}
	});

	return cartItems;
};


export const getTotalCount = async()=>{
	const cartItems = await getCartItems();
	const count = cartItems?.reduce((sum,item)=>(sum + item.count), 0);
	return count || 0;
}

export const getTotalPrice = async()=>{
	const cartItems = await getCartItems();
	const totalPrice = cartItems?.reduce((sum,item)=>(sum + item.price * item.count), 0);
	return totalPrice || 0;
}


// auth
let loggedInState
onAuthStateChanged(auth, (user) => {
	if (user) {
	  const uid = user.uid;
	  console.log(user.emailVerified)
	  alert("'logged in")
	  loggedInState = true
	} else {
	  loggedInState = false
	  alert("logged out")
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


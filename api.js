import { initializeApp } from "firebase/app";

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

// authentication
import {
	getAuth,
	createUserWithEmailAndPassword,
	signInWithPopup,
	GoogleAuthProvider,
	signInWithEmailAndPassword,
	signInAnonymously,
	onAuthStateChanged, 
	signOut
} from "firebase/auth";
import { nanoid } from 'nanoid'


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

// functions
export const getAllItems = async ()=>{
	const querySnapshot = await getDocs(itemsCollectionRef)
	const dataArray = await querySnapshot?.docs.map(doc =>{
		return {...doc.data(), id: doc.id + nanoid(10)}
	});
	return dataArray;
}


export const getSingleItem = async (id="")=>{

	const generalItemsRef = doc(db, "items", id[0].toString());
	const itemSnapShot = await getDoc(generalItemsRef);
	return {
		...itemSnapShot.data(),
		id: id
	}
}

export const getSingleCartItem = async (id)=>{
		const cartItems = await getCartItems();
		const item = cartItems.find(item=> item.id[0] === id[0]);
		return item
}

export const addItemToCart = async (id="")=>{
	try {
		const item = await getSingleItem(id);
		const user_uid = auth.currentUser?.uid || localStorage.getItem("user-uid");
		await setDoc(doc(db, "items-on-cart", id),{
			...item,
			count: 1,
			uid: user_uid
		})
	} 
	catch (err) {
		console.error(err.message);
	}
}

export const updateItemCount= async (id, count)=>{
	try {
		const itemRef = doc(db, "items-on-cart", id.toString());
		await updateDoc(itemRef, {
			count: Number(count)
		})
	} catch (err) {
		console.error(err)
	}
	
}

export const removeItem = async (id)=>{
	try{
		const itemRef = doc(db, "items-on-cart", id.toString());
		await deleteDoc(itemRef)
	}catch(err){
		console.error(err);
	}
}

export const getCartItems = async()=>{
	const cartItemsCollectionRef = collection(db,"items-on-cart");
	const userId = auth.currentUser?.uid || localStorage.getItem("user-uid");

	const q = query(cartItemsCollectionRef, where("uid", "==", userId))
	const querySnapshot = await getDocs(q);
	const cartItems = querySnapshot?.docs.map(doc =>{
		return {
			...doc.data()
		}
	});
	return cartItems
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

export const attempt= async (func)=>{
	try {
		const data = await func
		return data
	} catch (err) {
		console.error(err)
		return null
	}
}

// auth
onAuthStateChanged(auth, (user) => {
	if (user) {
	  const uid = user.uid;
	  localStorage.setItem("user-uid", uid)
	} else {
		localStorage.removeItem("user-uid");
	}
});

export const checkAuthState = ()=>{
	const user_uid = localStorage.getItem("user-uid")
	return user_uid ? true : false
}

export const authCreateAccountWithEmail = async (email, password)=>{
	try{
		const userCredential = await createUserWithEmailAndPassword(auth, email, password)
		const user = userCredential.user;
		alert("account successfully created!");
	}
	catch(error){
		console.error(error.message)
		alert(error.message) 
	}
}

export const anonymousSignIn = async()=>{
	try {
		await signInAnonymously(auth)
	} catch (error) {
		console.error(error.message)
	}
}

export const signInWithEmail = async (email, password)=>{
	// do I need to recive an isloggedIn boolean parameter? to return ?
	try{
		await signInWithEmailAndPassword(auth, email, password)
	}
	catch(error){
		console.error(error.message)
	}
}


export const authSignInWithGoogle= async()=> {
    try{
      await signInWithPopup(auth, provider)
    }
    catch(error){
      console.error(error.message)
    }
}

export const authSignOut= async()=>{
	try{
		await signOut(auth)
	}
	catch(error){
        console.error(error.message)
	}
}



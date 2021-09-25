//const Order = require('../../models/order');
//const Cart = require('../../models/cart');
//const Address = require('../../models/address');
//const axios = require('axios');
//
//var KHALTI_VERIFY = 'https://khalti.com/api/v2/payment/verify/';
//
//
//const addOrder = async (req, res, next) => {
//    try {
//        // console.log(req.user._id);
//        const deletingCart = await Cart.deleteOne({ user: req.user._id });
//        req.body.user = req.user._id;
//        req.body.orderStatus = [
//            {
//                type: "ordered",
//                date: new Date(),
//                isCompleted: true,
//            },
//            {
//                type: "packed",
//                isCompleted: false,
//            },
//            {
//                type: "shipped",
//                isCompleted: false,
//            },
//            {
//                type: "delivered",
//                isCompleted: false,
//            },
//        ];
//        // const token = req.headers.authorization.split(" ")[1];
//        // console.log(token);
//        if (req.body.paymentType == "khalti") {
//            // console.log(req.body.totalAmount)
//            // console.log(process.env.KHALTI_SECRET_KEY)
//            console.log(req.body.token)
//            let data = {
//                'token': req.body.token,
//                'amount': req.body.totalAmount
//            };
//            let config = {
//                headers: { 'Authorization': 'Key ${KHALTI_SECRET_KEY}' }
//            };
//            axios.post(KHALTI_VERIFY, data, config)
//                .then(response => {
//                    console.log(response.data);
//                    const order = new Order(req.body,);
//                    result = order.save();
//                    return res.status(200).json({
//                        message: "Cart deleted successful, Order placed",
//                        order, data: result,
//                        status: "success"
//                    });
//                })
//                .catch(error => {
//                    console.log(error);
//                    res.status(500).send({
//                        status: 'failed',
//                    });
//                });
//
//            let paymentProcess = await {
//                method: 'POST',
//                url: KHALTI_VERIFY,
//                body: JSON.stringify({
//                    'token': req.body.token,
//                    'amount': req.body.totalAmount
//                }),
//                headers: {
//                    "Authorization": Key ${process.env.KHALTI_SECRET_KEY},
//                    "Content-Type": 'application/json'
//                }
//            }
//            requestp(paymentProcess)
//                .then((result) => {
//                    console.log(response.data);
//
//
//                })
//                .catch((error) => {
//                    console.log(error);
//
//                });
//
//        } else {
//            const order = new Order(req.body);
//            result = order.save();
//            return res.status(200).json({
//                message: "Cart deleted successful, Order placed",
//                order, data: result,
//                status: "success"
//            });
//
//        }
//
//
//
//    } catch (error) {
//        res.status(500).json({
//            message: "Order failed",
//        });
//    }
//
//};
//
//const getOrders = async (req, res) => {
//    try {
//        const orders = await Order.find({ user: req.user._id })
//            .select("_id paymentStatus paymentType orderStatus items")
//            .populate("items.productId", "_id name productPictures");
//        return res.status(200).json({ orders });
//    }
//    catch (error) {
//        res.status(500).json({ error });
//    }
//}
//
//const getOrder = async (req, res) => {
//
//    try {
//        let { _id } = req.params;
//        // console.log(req.params)
//
//        const order = await Order.findOne({ _id })
//            .populate("items.productId", "_id name productImages")
//            .lean();
//        // console.log(order)
//
//        const findAddress = await Address.findOne({
//            user: req.user._id,
//        })
//        // console.log(findAddress)
//
//        order.address = await findAddress.address.find(
//            (adr) => adr._id.toString() == order.addressId.toString()
//        );
//
//        res.status(200).json({
//            order,
//        });
//    } catch (error) {
//        res.status(500).json({
//            message: "Failed to get products"
//        })
//    }
//};
//
//module.exports = {
//    addOrder,
//    getOrders,
//    getOrder
//}
//
//
//
//
//// const Order = require('../../models/order');
//// const Cart = require('../../models/cart');
//// const Address = require('../../models/address');
//
//// const addOrder = async (req, res, next) => {
////     try {
////         console.log(req.user._id);
////         const deletingCart = await Cart.deleteOne({ user: req.user._id });
//
////         req.body.user = req.user._id;
////         req.body.orderStatus = [
////             {
////                 type: "ordered",
////                 date: new Date(),
////                 isCompleted: true,
////             },
////             {
////                 type: "packed",
////                 isCompleted: false,
////             },
////             {
////                 type: "shipped",
////                 isCompleted: false,
////             },
////             {
////                 type: "delivered",
////                 isCompleted: false,
////             },
////         ]
////         //  console.log(req.body.user);
////         const order = new Order(req.body);
////         result = await order.save();
////         return res.status(200).json({
////             message: "Cart deleted successful, Order placed",
////             order
////         });
//
////     } catch (error) {
////         res.status(500).json({
////             message: "Order failed",
////         });
////     }
//
//// };
//
//// const getOrders = async (req, res) => {
////     try {
////         const orders = await Order.find({ user: req.user._id })
////             .select("_id paymentStatus paymentType orderStatus items")
////             .populate("items.productId", "_id name productPictures");
////         return res.status(200).json({ orders });
////     }
////     catch (error) {
////         res.status(500).json({ error });
////     }
//// }
//
//// const getOrder = async (req, res) => {
//
////     try {
////         let { _id } = req.params;
////         // console.log(req.params)
//
////         const order = await Order.findOne({ _id })
////             .populate("items.productId", "_id name productImages")
////             .lean();
////         // console.log(order)
//
////         const findAddress = await Address.findOne({
////             user: req.user._id,
////         })
////         // console.log(findAddress)
//
////         order.address = await findAddress.address.find(
////             (adr) => adr._id.toString() == order.addressId.toString()
////         );
//
////         res.status(200).json({
////             order,
////         });
////     } catch (error) {
////         res.status(500).json({
////             message: "Failed to get products"
////         })
////     }
//// };
//
//// module.exports = {
////     addOrder,
////     getOrders,
////     getOrder
//// }
import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/colors/colors.dart';
import 'package:flutter_tour_mate/db/db_firestore_helper.dart';
import 'package:flutter_tour_mate/models/expence_model.dart';
import 'package:flutter_tour_mate/providers/tour_provider.dart';
import 'package:flutter_tour_mate/style/text_styles.dart';
import 'package:flutter_tour_mate/utils/tour_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/toure_model.dart';

class TourDetailsPage extends StatefulWidget {
  static final routeName = '/tour_details';
  final String? id;

  TourDetailsPage({this.id});

  @override
  State<TourDetailsPage> createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  TourProvider? tourProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    tourProvider = Provider.of<TourProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'images/tourbackground2.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 70,
            child: FutureBuilder(
              future: DBFirestoreHelper.getTourById(String, widget.id),
              builder: (context, AsyncSnapshot<TourModel> snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: [
                      _buildSliverList(snapshot.data!),
                      SliverPadding(
                        padding: EdgeInsets.all(8.0),
                        sliver: SliverGrid.count(
                          crossAxisCount: 4,
                          childAspectRatio: 1,
                          children: List.generate(16, (index) =>
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(2.0),
                                color: Colors.white,
                                child: Text('image'),
                              )),
                        ),
                      )
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch data'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSliverList(TourModel tourModel) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _tourDetailsSection(tourModel),
        _tourExpanceSection(tourModel),
        _tourMomentHeaderSection(),
      ]),
    );
  }

  Widget _tourDetailsSection(TourModel tourModel) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(10),
          color: rowItemColor,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tourModel.tourName}',
                      style: textWhite16,
                    ),
                    Text(
                      'Starting on ${getFormatedDate(
                          tourModel.startDate!, 'MMM dd')}',
                      style: textWhite14,
                    ),
                    Text(
                      'Going to ${tourModel.destination}',
                      style: textWhite14,
                    )
                  ],
                ),
              ),
              Positioned(
                right: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Complete Tour', style: textWhite16,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tourExpanceSection(TourModel tourModel) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0),
            child: CircularPercentIndicator(
              animation: true,
              lineWidth: 10,
              radius: 50,
              percent: 0.8,
              progressColor: Colors.red,
              backgroundColor: Colors.white,
              center: Text('80%', style: textWhite30,),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expance', style: textWhite22,),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Text('Budget: ${tourModel.budget} Tk', style: textWhite16,),
                Text('Expance: 1000 Tk', style: textWhite16,),
                Text('Remaining: 9000 Tk', style: textWhite16,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _showAddExpenceDialog,
                      icon: Icon(Icons.add, color: Colors.white,),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.list, color: Colors.white,),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tourMomentHeaderSection() {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Moments', style: textWhite22,),
              Text('11 images found', style: textWhite16,),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt, color: Colors.white,),
          )
        ],
      ),
    );
  }

  void _showAddExpenceDialog() {
    ExpenceModel expenceModel = ExpenceModel(tourId: widget.id);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: backgroundColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Add New Expense',style: TextStyle(color: Colors.white),),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelStyle: textWhite14,
                    filled: true,
                    fillColor: rowItemColor,
                    labelText: 'Expense Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Name should not be empty';
                    }
                    return null;
                  },
                  onSaved: (value){
                    expenceModel.expenseName = value;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: textWhite14,
                    filled: true,
                    fillColor: rowItemColor,
                    labelText: 'Expense Amount',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Amount should not be empty';
                    }
                    if(double.parse(value)<=0.0){
                      return 'Amount should be greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value){
                    expenceModel.expenseAmount = double.parse(value!);
                  },
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: rowItemColor
              ),
                onPressed: ()=>Navigator.pop(context,false),
                child: Text('CANCEL',style: TextStyle(color: Colors.white),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: rowItemColor
              ),
                onPressed: (){
                  _saveExpense(expenceModel).then((value) => Navigator.pop(context));
                },
                child: Text('ADD',style: TextStyle(color: Colors.white),)
            )
          ],
        )
    );
  }

  Future _saveExpense(ExpenceModel expenceModel) async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      expenceModel.expenseDate = DateTime.now().microsecondsSinceEpoch;
      await tourProvider!.saveExpense(expenceModel);
    }
  }
}

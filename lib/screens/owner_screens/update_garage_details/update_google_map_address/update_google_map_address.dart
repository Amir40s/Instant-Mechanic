import 'package:car_mechanics/helpers/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/update_garage_details_provider.dart';


class UpdateGoogleMapAddress extends StatelessWidget {
  UpdateGoogleMapAddress({super.key});


  @override
  Widget build(BuildContext context) {
    var googleP = Provider.of<ShopDetailsUpdateProvider>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map"),
        ),
        body: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Consumer<ShopDetailsUpdateProvider>(builder: (context,provider,_){
              return Stack(
                  children:[
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(provider.kGooglePlex.target.latitude,provider.kGooglePlex.target.longitude),
                        zoom: 14.0,
                      ),
                      markers: <Marker>{
                        Marker(
                          markerId: MarkerId("1"),
                          position: LatLng(provider.kGooglePlex.target.latitude,provider.kGooglePlex.target.longitude),
                        ),
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (controller){
                        // provider.gController.complete(controller);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 5,),
                          // InputField(inputController: provider.searchController,hintText: "Search Places with Name",),
                          TextFormField(
                            onTap: (){
                              provider.suggestions = true;
                            },
                            onChanged: (value){
                              provider.onChanged(value.toString());
                            },
                            controller: provider.searchController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              hintText: "Search Places with Name",
                            ),
                          ),
                          provider.suggestions == true ? SizedBox(
                              height: 30.h,
                              width: 100.w,
                              child: ListView.builder(
                                  itemCount: provider.placesList.length,
                                  itemBuilder: (context,index){
                                    return GestureDetector(
                                      onTap: () async {
                                        provider.suggestions = false;
                                        FocusScope.of(context).unfocus();
                                        List<Location> locations = await locationFromAddress(provider.placesList[index]["description"]);
                                        provider.moveLocation(locations.last.latitude, locations.last.longitude,index);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: 100.w,
                                        decoration: BoxDecoration(color: Colors.white),
                                        child: Text(provider.placesList[index]["description"]),
                                      ),
                                    );
                                  })):const SizedBox(),
                        ],
                      ),
                    ),
                  ]
              );
            })
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SubmitButton(
            width: 50.w,
            title: "Save Location",
            press: ()async{
              await googleP.saveLocation(context);
            })
      // FloatingActionButton(
      //   backgroundColor: appBarTextColor,
      //   child: Icon(CupertinoIcons.location_solid,color: appColor,),
      //     onPressed: ()async{
      //     await googleP.loadLocation();
      //     },
      // ),
    );
  }
}

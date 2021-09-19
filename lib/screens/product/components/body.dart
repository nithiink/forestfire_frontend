import 'package:flutter/material.dart';
import 'package:forestfire_frontend/sizeConfig.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:flutter_js/flutter_js.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  // JS Code
  final JavascriptRuntime javascriptRuntime = getJavascriptRuntime();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    print(javascriptRuntime.evaluate("""
  const XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;

// NOTE: you must manually enter your API_KEY below using information retrieved from your IBM Cloud
const API_KEY = "1bbf9714b9ac4babbf9714b9acebabca";

function getToken(errorCallback, loadCallback) {
    const req = new XMLHttpRequest();
    req.addEventListener("load", loadCallback);
    req.addEventListener("error", errorCallback);
    req.open("POST", "https://iam.cloud.ibm.com/identity/token");
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.setRequestHeader("Accept", "application/json");
    req.send("grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=" + API_KEY);
}

function apiPost(scoring_url, token, payload, loadCallback, errorCallback){
    const oReq = new XMLHttpRequest();
    oReq.addEventListener("load", loadCallback);
    oReq.addEventListener("error", errorCallback);
    oReq.open("POST", scoring_url);
    oReq.setRequestHeader("Accept", "application/json");
    oReq.setRequestHeader("Authorization", "Bearer " + token);
    oReq.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    oReq.send(payload);
}

getToken((err) => console.log(err), function () {
    let tokenResponse;
    try {
        tokenResponse = JSON.parse(this.responseText);
    } catch(ex) {
        // TODO: handle parsing exception
    }
    // NOTE: manually define and pass the array(s) of values to be scored in the next line
    const payload = '{"input_data": [{"fields": [array_of_input_fields], "values": [array_of_values_to_be_scored, another_array_of_values_to_be_scored]}]}';
    const scoring_url = "https://eu-de.ml.cloud.ibm.com/ml/v4/deployments/2f62c24e-ab50-4c11-bb79-da30b5ae58c5/predictions?version=2021-09-19&version=2021-09-19";
    apiPost(scoring_url, tokenResponse.token, payload, function (resp) {
        let parsedPostResponse;
        try {
            parsedPostResponse = JSON.parse(this.responseText);
        } catch (ex) {
            // TODO: handle parsing exception
        }
        console.log("Scoring response");
        console.log(parsedPostResponse);
    }, function (error) {
        console.log(error);
    });
});
  
   """).stringResult);
    return Center(
      child: Container(
        // color: Colors.black,
        child: Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(62)),
            Expanded(
              flex: 1,
              child: DetailsWidget(),
            ),
            Expanded(
              flex: 3,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  String dropdownValue = "Enter the Location";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getProportionateScreenHeight(100),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Map",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: getProportionateScreenWidth(22))),
              TextSpan(
                text: "View",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: getProportionateScreenWidth(22),
                      color: Color(0xFF797979).withOpacity(0.42),
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(75),
        ),
        GestureDetector(
          child: Row(
            children: [
              Icon(Icons.search_rounded),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Text(
                "Enter the Location",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: getProportionateScreenWidth(30),
                      color: Color(0xFFB1B1B1).withOpacity(0.60),
                    ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacePicker(
                  apiKey:
                      "AIzaSyA2j6KhvI7EcC5YDmL2i3anoStilovekwM", // Put YOUR OWN KEY here.
                  onPlacePicked: (result) {
                    print(result.geometry.toString());
                    Navigator.of(context).pop();
                  },
                  initialPosition: LatLng(-33.8567844, 151.213108),
                  useCurrentLocation: true,
                ),
              ),
            );
          },
        ),
        DropdownButton<String>(
          value: dropdownValue,
          elevation: 16,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: getProportionateScreenWidth(30),
                color: Colors.black,
              ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            'Select the Location',
            'Location 2',
            'Location 3',
            'Location 4'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

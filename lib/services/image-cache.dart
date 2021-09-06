import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';



 CachedNetworkImage showProductImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => LinearProgressIndicator(),
       errorWidget: (context, url, error) {
        // error is a HttpExceptionWithStatus object and
        // has properties:
        // message → String; runtimeType → Type;
        // statusCode → int; uri → Uri
        var _errorText = "Image unavailable\n";
        if (error.statusCode == 403 || error.statusCode == 404) {}
        return Center(
          child: Text(
            _errorText,
            style: TextStyle(
                color: Colors.redAccent[700], fontWeight: FontWeight.bold),
          ),
        );
      }
      // errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

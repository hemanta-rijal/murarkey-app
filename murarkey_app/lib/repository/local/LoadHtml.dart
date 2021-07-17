/**
 * Created by Suman Prasad Neupane on 7/17/2021.
 */

class LoadHtml{
  //sample

  //import 'package:html/parser.dart' as htmlparser;
  // import 'package:html/dom.dart' as dom;
  // import 'package:flutter_html/flutter_html.dart';


  // Widget html() {
  //     return Html(
  //       data: LoadHtml.htmlData,
  //     );
  //     //tagsList: Html.tags..remove(Platform.isAndroid ? "iframe" : "video"));
  //   }

  static String htmlData = """<div>
  <h1>Demo Page</h1>
  <p>This is a fantastic product that you should buy!</p>
  <h3>Features</h3>
  <ul>
    <li>It actually works</li>
    <li>It exists</li>
    <li>It doesn't cost much!</li>
  </ul>
  <svg id='svg1' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'>
            <circle r="32" cx="35" cy="65" fill="#F00" opacity="0.5"/>
            <circle r="32" cx="65" cy="65" fill="#0F0" opacity="0.5"/>
            <circle r="32" cx="50" cy="35" fill="#00F" opacity="0.5"/>
            
             <img src='https://flutter.dev/images/flutter-mono-81x100.png' />
             
             <p style="color:blue">This is demo content.</p>
             <h1 style="background-color:powderblue;">This is a heading</h1>
<p style="background-color:tomato;">This is a paragraph.</p>
         
          <h3>youtube video</h3>    
     <iframe 
        src="https://www.youtube.com/embed/W8TrvLoPrfQ" 
        height="100" 
        frameborder="1"></iframe>
        
        <h3>stored video</h3>   
         <video controls>
    <source src="https://www.w3schools.com/html/mov_bbb.mp4" />
  </video>
    
        
  <!--You can pretty much put any html in here!-->
</div>""";
}
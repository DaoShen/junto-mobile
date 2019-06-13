
class Expression {
  final String expressionType;
  final String time;
  final String title;
  final String location;
  final String body;
  final String image;
  final String imageCaption;
  final String shortformText;
  final String channelOne;
  final String channelTwo;
  final String channelThree;

  Expression({this.expressionType, this.time, this.title, this.location, this.body, this.image, this.imageCaption, this.shortformText, this.channelOne, this.channelTwo,this.channelThree,});
  static fetchAll() {

      return [   
        Expression(
            expressionType: 'longform',
            time: '2',
            title: 'The Medium is the Message',
            body: 'The forms we communicate through are just as important as the message itself. The evolution of social media starts with revisiting the fundamentals and redesigning them in more humane ways.',
            image: null,
            imageCaption: null, 
            shortformText: null,
            channelOne: 'technology',
            channelTwo: 'design',
            channelThree: 'authenticity'
        ),

        Expression(
          expressionType: 'photo', 
          time: '17',
          title: null, 
          body: null,
          image: 'assets/images/junto-mobile__expression--photo.png',
          imageCaption: 'Some exciting developments happening between Junto and Holochain coming your way.',
          shortformText: null,
          channelOne: 'holochain',
          channelTwo: 'junto',
          channelThree: ''          
        ),

        Expression(
          expressionType: 'shortform', 
          time: '22',
          title: null, 
          body: null, 
          image: null,
          imageCaption: null, 
          shortformText: 'Get ready for our 2019 release!',
          channelOne: '',
          channelTwo: '',
          channelThree: ''             
        ), 

        Expression(
          expressionType: 'event', 
          time: '24',
          title: 'Saturday Zazen Meditation at Still Mind Zendo', 
          location: 'Still Mind Zendo',
          body: null, 
          image: 'assets/images/junto-mobile__stillmind.png',
          imageCaption: null, 
          shortformText: 'Get ready for our 2019 release!',
          channelOne: '',
          channelTwo: '',
          channelThree: ''             
        ),         

        Expression(
          expressionType: 'longform', 
          time: '45',
          title: 'Rebalancing our relationship with technology', 
          body: 'Junto is a new breed of social media. Our goal is to rebalance our relationship with technology.', 
          image: null,
          imageCaption: null, 
          shortformText: null,
          channelOne: '',
          channelTwo: '',
          channelThree: 'hello'             
        ),       
        

        Expression(
          expressionType: 'shortform', 
          time: '57',
          title: null, 
          body: null, 
          image: null,
          imageCaption: null, 
          shortformText: 'This is a shortform expression. There will likely be 220 characters that will be overlayed against a beautiful gradient.',
          channelOne: 'hype',
          channelTwo: 'junto',
          channelThree: ''             
        ),           

        Expression(
          expressionType: 'event', 
          time: '24',
          title: 'Junto Den Freeform II', 
          location: 'Junto Haus',
          body: null, 
          image: 'assets/images/junto-mobile__ecstatic.png',
          imageCaption: null, 
          shortformText: 'Get ready for our 2019 release!',
          channelOne: '',
          channelTwo: '',
          channelThree: ''             
        ), 

        Expression(
          expressionType: 'photo', 
          time: '17',
          title: null, 
          body: null,
          image: 'assets/images/junto-mobile__expression--photo.png',
          imageCaption: '',
          shortformText: null,
          channelOne: '',
          channelTwo: '',
          channelThree: ''          
        ),      

        Expression(
            expressionType: 'longform',
            time: '2',
            title: 'The Medium is the Message: Rebalancing Our Relationship With Technology',
            body: 'The forms we communicate through are just as important as the message itself. The evolution of social media starts with revisiting the fundamentals and redesigning them in more humane ways.  The forms we communicate through are just as important as the message itself. The evolution of social media starts with revisiting the fundamentals and redesigning them in more humane ways  The forms we communicate through are just as important as the message itself. The evolution of social media starts with revisiting the fundamentals and redesigning them in more humane ways  The forms we communicate through are just as important as the message itself. The evolution of social media starts with revisiting the fundamentals and redesigning them in more humane ways',
            image: null,
            imageCaption: null, 
            shortformText: null,
            channelOne: 'technology',
            channelTwo: 'design',
            channelThree: 'authenticity'
        ),                 
      ];
    }
}
 
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/models/sphere.dart';

UserProfile kUserProfile = const UserProfile(
  address: '123e4567-e89b-23s3-a256-426655440000',
  bio: 'Hi there, this is a mock user profile',
  name: 'Testy',
  profilePicture: <String>['assets/images/junto-mobile__mockprofpic--one.png'],
  username: 'mcTesty',
  verified: false,
  website: <String>['https://www.twitter.com/Nash0x7E2'],
  location: <String>['Somewhere on Earth'],
  gender: <String>['Male'],
);

UserData kUserData = UserData(
  userPerspective: kPerspectives.first,
  user: kUserProfile,
  pack: kPack,
  publicDen: kPublicDen,
  privateDen: kPrivateDen,
  connectionPerspective: kPerspectives[1],
);

CentralizedDen kPublicDen = CentralizedDen(
  creator: kUserProfile.address,
  privacy: 'Public',
  isDefault: false,
  name: 'Mock Public Den',
  address: '123123-34345345-23422423',
);
CentralizedDen kPrivateDen = CentralizedDen(
  creator: kUserProfile.address,
  privacy: 'Private',
  isDefault: false,
  name: 'Mock Public Den',
  address: '123123-34345345-23422423',
);

CentralizedPack kPack = CentralizedPack(
  createdAt: DateTime(2019, 07, 04),
  privacy: 'Public',
  creator: kUserProfile.address,
  isDefault: false,
  name: 'Mock Pack',
  address: '12123123-345345-2321',
);

Comment kComment = Comment(
  address: '123e4567-e89b-23s3-a256-426655440000',
  comments: 0,
  context: 'collective',
  createdAt: DateTime.now(),
  creator: kUserProfile,
  expressionData: CentralizedLongFormExpression(
    title: 'Mocking',
    body: 'Expressions',
  ),
  privacy: 'Public',
  resonations: 0,
  type: 'LongForm',
);

Resonation kResonation = Resonation(
  expressionAddress: '123e4567-e89b-12d3-a456-426655440000',
  groupAddress: null,
  linkType: 'Resonation',
);

CentralizedExpressionResponse kExpressionResponse =
    CentralizedExpressionResponse(
  address: '123e4567-e89b-12d3-a456-426655440000',
  numberComments: 1,
  context: 'collective',
  createdAt: DateTime.now(),
  creator: kUserProfile,
  expressionData:
      CentralizedLongFormExpression(title: 'Mocking', body: 'Expressions'),
  numberResonations: 0,
  privacy: 'Public',
  resonations: <UserProfile>[],
  type: 'LongForm',
);

List<CentralizedExpressionResponse> kSampleExpressions =
    <CentralizedExpressionResponse>[
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'LongForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      bio: 'hellooo',
      name: 'Eric',
      profilePicture: <String>['assets/images/junto-mobile__eric.png'],
      username: 'sunyata',
      verified: true,
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
      address: 'ajdsbasbd-4234jdsf-dfmbjs',
    ),
    expressionData: CentralizedLongFormExpression(
      title: 'Dynamic form is in motion!',
      body: "Hey! Eric here. We're currently working with a London-based dev "
          "agency called DevAngels to build out our dynamic, rich text editor. Soon, you'll be able to create short or longform expressions that contain text, links, images complemented with features such as bullet points, horiozntal lines, bold and italic font, and much more. This should be done in the next 1 or 2 weeks so stay tuned!",
    ),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'ShortForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      name: 'Dora',
      profilePicture: <String>['assets/images/junto-mobile__dora.png'],
      bio: 'hellooo',
      username: 'wingedmessenger',
      verified: true,
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
      address: 'testing-address',
    ),
    expressionData: CentralizedShortFormExpression(
      background: 'four',
      body: ' Have you heard of Paradym sound healing meditation? Join us for '
          'a transformational session this Friday!',
    ),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'PhotoForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      name: 'Josh',
      profilePicture: <String>['assets/images/junto-mobile__josh.png'],
      bio: 'hellooo',
      address: 'parent-address',
      verified: true,
      username: 'jdlparkin',
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
    ),
    expressionData: CentralizedPhotoFormExpression(
      image: 'assets/images/junto-mobile__photo--one.png',
      caption: 'Catching some waves in New Polzeath!',
    ),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'EventForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      address: 'parent-address',
      bio: "I'm Drea.",
      name: 'Drea',
      profilePicture: <String>['assets/images/junto-mobile__drea.png'],
      verified: true,
      username: 'DMONEY',
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
    ),
    expressionData: CentralizedEventFormExpression(
        title: 'Junto Presents: Jazz and Draw',
        // location: 'The Assemblage',
        // startTime: 'Sun, Sep 15, 3:00PM',
        photo: 'assets/images/junto-mobile__event--one.png',
        description:
            "Join us for a splendiferous afternoon of paint-splattering fun! We'll be syncing our movements to your favorite blues while creating beautiful masterpieces together. All are invited!"),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'LongForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      address: '0vefoiwiafjvkbr32r243r5',
      bio: 'hellooo',
      name: 'Nash',
      profilePicture: <String>['assets/images/junto-mobile__nash.png'],
      verified: true,
      username: 'Nash',
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
    ),
    expressionData: CentralizedLongFormExpression(
      // title: 'Welcome to Junto!',
      title: '',
      body: "Hey! I'm Nash. Over the past few weeks, I've been working with"
          " Eric and the rest of the Junto team to prepare for Junto's "
          'upcoming release. I also just finished a project for the '
          "government of Trinidad and Tobago (where i'm from) and I'm stoked to say we won first place! Anyway, really looking forward to watching this g,o live. Can't wait to meet you all!",
    ),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'PhotoForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      address: '0vefoiwiafjvkbr32r243r5',
      name: 'Yaz',
      profilePicture: <String>['assets/images/junto-mobile__yaz.png'],
      bio: 'hellooo',
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
      verified: true,
      username: 'yaz',
    ),
    expressionData: CentralizedPhotoFormExpression(
      image: 'assets/images/junto-mobile__photo--two.png',
      caption: 'Hi, Yaz here!',
    ),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'LongForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      address: '0vefoiwiafjvkbr32r243r5',
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
      name: 'Tomis',
      profilePicture: <String>['assets/images/junto-mobile__tomis.png'],
      verified: true,
      bio: 'hellooo',
      username: 'tomis',
    ),
    expressionData: CentralizedLongFormExpression(
      title: 'The funny story about my name...',
      body: "A question I get all the time is, 'Is that your real name?' "
          "Well, I'm glad you asked. You see, it was a hot afternoon in Lexington, Kentucky. Feeling hangry, I swung by the closest Subway shop and...",
    ),
  ),
  CentralizedExpressionResponse(
    address: '0xfee32zokie8',
    type: 'EventForm',
    numberComments: 1,
    context: '',
    createdAt: DateTime.now(),
    creator: const UserProfile(
      address: '0vefoiwiafjvkbr32r243r5',
      website: <String>['https://www.twitter.com/Junto'],
      location: <String>['Somewhere on Earth'],
      gender: <String>[],
      bio: "I'm Leif.",
      name: 'Leif',
      profilePicture: <String>['assets/images/junto-mobile__leif.png'],
      verified: true,
      username: 'leifthelion',
    ),
    expressionData: CentralizedEventFormExpression(
        title: 'Happiness is Your True Nature',
        // location: 'within',
        // startTime: 'ANYTIME',
        photo: 'assets/images/junto-mobile__event--two.png',
        description:
            "Now, you may not be as muscular as this stud. But let me tell you - You. Are. Beautiful. Everything you need is within, so come book an appointmnet with Happy Leif and we're guarantee you some Happy Photos ;)"),
  ),
];

List<Group> kGroups = <Group>[
  Group(
    address: 'assets/images/junto-mobile__eric.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Eric Yang',
      address: 'mock-slim-user-adr',
      username: 'eric',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 0,
    facilitators: 2,
    groupData: GroupDataPack(name: 'Yang Gang'),
  ),
  Group(
    address: 'assets/images/junto-mobile__riley.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Riley Wagner',
      address: 'mock-slim-user-adr',
      username: 'Riley',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Wags'),
  ),
  Group(
    address: 'assets/images/junto-mobile__josh.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Josh Parkin',
      address: 'mock-slim-user-adr',
      username: 'Josh',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'The Way'),
  ),
  Group(
    address: 'assets/images/junto-mobile__yaz.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Yaz Owainati',
      address: 'mock-slim-user-adr',
      username: 'Yaz',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 0,
    facilitators: 2,
    groupData: GroupDataPack(name: 'Jasmine Flowers'),
  ),
  Group(
    address: 'assets/images/junto-mobile__tomis.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Tomis Parker',
      address: 'mock-slim-user-adr',
      username: 'Tomis',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Self-Directed AF'),
  ),
  Group(
    address: 'assets/images/junto-mobile__nash.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Nash Ramdial',
      address: 'mock-slim-user-adr',
      username: 'Nash',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Nash Flash'),
  ),
  Group(
    address: 'assets/images/junto-mobile__drea.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Drea Bennett',
      address: 'mock-slim-user-adr',
      username: 'Drea',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Greene House'),
  ),
  Group(
    address: 'assets/images/junto-mobile__dora.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Dora Czovek',
      address: 'mock-slim-user-adr',
      username: 'Dora',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'The Spaceship'),
  ),
  Group(
    address: 'assets/images/junto-mobile__kevin.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Kevin Yang',
      address: 'mock-slim-user-adr',
      username: 'Kevin',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Yangsters'),
  ),
  Group(
    address: 'assets/images/junto-mobile__ekene.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Ekene Nkem-Mmekam',
      address: 'mock-slim-user-adr',
      username: 'Ekene',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'FlatTops'),
  ),
  Group(
    address: 'assets/images/junto-mobile__david.png',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'David Wu',
      address: 'mock-slim-user-adr',
      username: 'David',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Wuseph'),
  ),
  Group(
    address: '',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Ali Makhdoom',
      address: 'mock-slim-user-adr',
      username: 'Ali',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Mopbroomsters'),
  ),
  Group(
    address: '',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Vidit Gupta',
      address: 'mock-slim-user-adr',
      username: 'Ali',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'Wanderers'),
  ),
  Group(
    address: '',
    createdAt: DateTime.now(),
    creator: 'mock-group-creator',
    incomingCreator: const SlimUserResponse(
      name: 'Diana Ruan',
      address: 'mock-slim-user-adr',
      username: 'Diana',
    ),
    privacy: 'public',
    groupType: 'sphere',
    members: 1,
    facilitators: 0,
    groupData: GroupDataPack(name: 'The Playgruand'),
  ),
];

List<UserProfile> kUsers = <UserProfile>[
  const UserProfile(
    address: '123e4567-e89b-23s3-a256-426655440000',
    bio: 'Hi there, this is a mock user profile',
    name: 'Testy',
    profilePicture: <String>['assets/images/junto-mobile__junto.png'],
    username: 'mcTesty',
    verified: false,
    website: <String>['https://www.twitter.com/Nash0x7E2'],
    location: <String>['Somewhere on Earth'],
    gender: <String>['Male'],
  ),
  const UserProfile(
    address: '223e4567-e89b-23s3-a256-426655440000',
    bio: 'Dreaaaaa',
    name: 'Drea',
    profilePicture: <String>['assets/images/junto-mobile__junto.png'],
    username: 'DMONEY',
    verified: false,
    website: <String>['https://www.twitter.com/JUNTO'],
    location: <String>['Somewhere on Earth'],
    gender: <String>['Female'],
  ),
  const UserProfile(
    address: '323e4567-e89b-23s3-a256-426655440000',
    bio: 'Ericccccc',
    name: 'Eric Yang',
    profilePicture: <String>['assets/images/junto-mobile__junto.png'],
    username: 'sunyata',
    verified: false,
    website: <String>['https://www.twitter.com/JUNTO'],
    location: <String>['Somewhere on Earth'],
    gender: <String>['Male'],
  ),
];

List<Users> kGroupUsers = <Users>[
  Users(user: kUsers[0], permissionLevel: 'Admin'),
  Users(user: kUsers[1], permissionLevel: 'Member'),
  Users(user: kUsers[2], permissionLevel: 'Member'),
];

List<CentralizedPerspective> kPerspectives = <CentralizedPerspective>[
  CentralizedPerspective(
    creator: kUserProfile.address,
    about: 'Mock Perspective One',
    createdAt: DateTime(2019, 06, 06),
    isDefault: false,
    name: 'Mock One',
    address: '123123-3452345-234234',
  ),
  CentralizedPerspective(
    creator: kGroupUsers[1].user.address,
    about: 'Mock Perspective Two',
    createdAt: DateTime(2019, 06, 07),
    isDefault: false,
    name: 'Mock Two',
    address: '223123-3452345-234234',
  ),
  CentralizedPerspective(
    creator: kUserProfile.address,
    about: 'Mock Perspective Three',
    createdAt: DateTime(2019, 06, 08),
    isDefault: false,
    name: 'Mock Three',
    address: '323123-3452345-234234',
  ),
];

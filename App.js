/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Button,
  Image,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import PhotoUtil from './utils/PhotoUtil';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      img_url: '',
    };
  }

  open() {
    PhotoUtil.openPhotoLibrary((error,images) => {
      let url = (images && images.length > 0) ? images[0] : '';
      this.setState({
        img_url: url,
      });
    });
  }

  render() {
    let url = this.state.img_url;
    return (
      <SafeAreaView style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <Button title={'open photoLibrary'} onPress={() => this.open()}/>
        <Image
          source={{
            uri: url,
          }}
          style = {{backgroundColor: 'gray', width: 100, height: 100}}
        />
      </SafeAreaView>
    );
  }
}

export default App;

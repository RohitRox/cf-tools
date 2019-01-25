import { shallow } from 'enzyme';
import * as React from 'react';

import Hello from '.';

it('renders the heading', () => {
  const result = shallow(<Hello compiler="Typescript" framework="React" bundler="Webpack"/>);
  expect(result.find('h1').text()).toEqual('This is a React application using Typescript with Webpack');
});

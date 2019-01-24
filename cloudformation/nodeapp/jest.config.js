module.exports = {
  "setupFiles": [
    "<rootDir>/test-setup.js"
  ],
  moduleFileExtensions: [
    "ts",
    "tsx",
    "js"
  ],
  transform: {
    "^.+\\.(ts|tsx)$": "ts-jest"
  },
  "transformIgnorePatterns": [
    // "/node_modules/(?!cloudfactory-ui-foundation).+\\.jsx$" Enable to use tsx from node modules
  ],
  testMatch: [
    "**/__tests__/*.(ts|tsx|js)"
  ]
}
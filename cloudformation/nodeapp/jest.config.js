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
  testMatch: [
    "**/__tests__/*.(ts|tsx|js)"
  ]
}
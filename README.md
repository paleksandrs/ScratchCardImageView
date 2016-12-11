# Scratchcard effect

To achieve scratchcard effect you have to options `ScratchCardTouchContainer` or `ScratchCardImageView`
![example](example.png)

###ScratchCardTouchContainer

A simple `UIView` subclass that allows tracking touch events already outside your `UIImageView` that represents your scratchcard. Just simple pass reference to your scratchcard image view.  

Example: 

````swift
scratchCardTouchContainer.scratchCardImageView = scratchCard
scratchCardTouchContainer.lineType = .square
scratchCardTouchContainer.lineWidth = 20 
````

### ScratchCardImageView

A simple `UIImageView` subclass that allows your `UIImageView` become a scratchcard. Touch events will be tracked only inside the `UIImageView` bounds. In the storyboard or xib set custom class of your `UIImageView` that represents your scratchcard image to `ScratchCardImageView`

## License

`ScratchCardImageView` and `ScratchCardTouchContainer` is released under an [MIT License][mitLink]. See `LICENSE` for details.

[mitLink]:http://opensource.org/licenses/MIT

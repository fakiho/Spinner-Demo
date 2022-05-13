# Hue Spinner

## How to make a customized Spinner with stroke, hue, and rotation animation in 2 simple ways

While working on a project you will have to deal with customized UI components, sometimes the customization is a bit complicated and it will add complexity to your project. In my case, I had to create a customized button with specific padding for the title, and a loading indicator when the state is loading.
So I had to start from somewhere, and I decided to create my own loading indicator like what we going to see later in this article
For this project, I have created two types of loading indicators, I named them HueSpinnerView & SpinnerView. For SpinnerView we're going to use CABasicAnimation to achieve the circular animation. While in HueSpinnerView we will be using CAKeyframeAnimation in order to have a circular animation with custom timing & animated stroke hue.

## Code Time

Let us begin with creating a simple class of `UIView` for `SpinnerView`

we make sure that in the `layoutSubviews` layer will be rounded by setting its `cornerRadius` equal to `frame.width / 2`.
If you are wondering what is a layer? The layer is the object that manages image-based content and allows you to perform animations on that content.
To draw the circle we need to create a `customCAShapeLayer` . The `CAShapeLayer` is a layer that draws a cubic Bezier spline in its coordinate space. The shape is comprised between the layer's contents and its first sublayer.

We are going to use the SpinnerShapeLayer to draw the circular shape, but let us see the properties declared within SpinnerShapeLayer 
strokeColor The color of the path

- `lineWidth` determines the width of the path

- `fillColor` background-color of the path layer

- `lineCap` specifies the shape of the endpoints of an open path when stroked. In our case we wanted it .round

### Let's go back and update our existing SpinnerView and update it

Now you can see a new private property of SpinnerShapeLayer type and 

that the initializer has `strokeColor` & `lineWidth` with `frame = .zero` to help us initialize the `SpinnerShapeLayer `.
A new function `configureShapePath()` called in `func layoutSubviews()` to create the path of theshapeLayer , the path is an animatable property and may be animated using any of the concrete subclasses of `CAPropertyAnimation`

```class CAPropertyAnimation : CAAnimation```

> The property to animate is specified using a key path that is relative to the layer using the animation. You do not create instances of CAPropertyAnimation to animate the properties of a Core Animation layer, create instance of the concrete subclasses `CABasicAnimation` or `CAKeyframeAnimation`
> 
>[Apple Developer Documentation](https://developer.apple.com/documentation/quartzcore/capropertyanimation)

Stroke Animation
Now after that said, it is time for `CABasicAnimation` class . We are going to create a new class `StrokeAnimation` as follows:

An `enum State` to specify the stroke animation type, start & end signify the edge of the path, and the `animationKey` the name says it all.

An initializer that takes `state`, `beginTime`, `fromValue`, `toValue` and `duration` as arguments. Based on the state we're going to define the stoke animation by assigning it to the `keyPath`.

the `timingFunction` of type `CAMediaTimingFunction` represents one segment of a function that defines the pacing of animation as a timing curve, in simple words, it will make our animation start and end slowly.

Full tutorial exist on <img src="https://cdn-icons-png.flaticon.com/512/5968/5968885.png" width=30>[MEDIUM](https://fakiho.medium.com/custom-spinner-5592d5a13997)

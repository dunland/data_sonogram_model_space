# Model Based Sonification
outline for tutorial video

## What is Model Based Sonification?

Model-Based Sonification is a special technique in the realm of Sonification, which is concerned with the structural order of a dataset that is to be sonified.  
In order to explain what Model-Based Sonification is in detail, we first have to get an overview about what a _Sonification_ is. In simple terms, it is the use of nonspeech audio to convey information [1](#01).
Exemplary Applications using Sonification are Pulse Oximeters (representing someone's heart beat rate), the Geiger Counter (analoguely to nuclear radiation activity) or the Park Distance Control in cars).   So called __Earcons__, deriving their name analoguely from the visual Icons, can be very helpful not only for visually impaired people using digital interfaces: In situations where one has to use their visual sense besides the hearing sense simultaneously, like navigating a car through the city, an Earcon can give you additional information about your orientation, acceleration and incline or tell you about the internal state of the navigational interface itself (e.g. what menu you are in and what input options you have).

So in one way or another, sonification is always using some raw input data to shift it into an aurally perceivable range.  
The International Community for Auditory Display, in short __ICAD__, adds, that

> More specifically, sonification is the transformation of data relations into perceived relations in an acoustic signal for the purposes of facilitating communication or interpretation. [1](#01)  

Some datasets, such as any dataseries you would find for example in historical data, climate records, chemical reaction processes, or any other data that is sampled in whatever sized time intervals are strongly time-based.  
Some of them, such as the beat of the heart, fall within the range of human hearing capabilities and thus can be heard without being translated into other time scales. They don't have to be pitched up or slowed down to be aurally perceptible.  
Actions too fast or slow for us to be perceived have to be translated into a hearable range, or used as triggers for aural events, change the sound volume, filter the sound or invoke other longer-scale sound manipulations.  
Either way, the sonification of timebased datasets can be done quite straightforwardly, since sound itself is a medium that carries information in time.  
Finding outstanding information or inconsistencies in big datasets can thus be achieved perfectly through simple parameter-to-sound-mapping. But it will always give you only information about a two-dimensional set of datapoints.  

So if we're dealing with either higher-dimensional data, or data that is not structured in a timely manner, and if we still want to get a deeper understanding of the relation of the data points, what we'll have to use is:

## Model-Based Sonification

### Definition

The Model-Based Sonification is concerned with the structure, allocation and variance of a dataset.
Its focus strongly lies on the data **relations**. While in parameter-mapping-sonification, we investigate the general course of data points of a (mostly two-dimensional) dataset and search for peaks and unregularities, with model-based sonification we can enter another dimension of the dataset and investigate more closely the relation and distribution of the data points.  
Now how do we do that?  
This is where our own _model_ will come into play. The ultimate goal of this sonification technique is to find a model that enables us to understand the data distribution. We can best conceive best of our datapool as a set of dots that can be excited, and of which each dot will respond acoustically when activated. This way, we will be able to hear the dataset's _motion_ as a response to the agitation, where the dynamics of this process correspond immediately to the interrelations of the data samples.  
The model by which we let the samples react, i.e. the way, in which we use the data as parameters for our model, is to be designed in a way that makes it easy to use and to understand. This model will become our tool to analyze different scenarios with.  
The most comprehensive summary of Model Based Sonification I found is given by Thomas Hermann, Andy Hunt and John G. Neuhoff in their "Sonification Handbook" (in chapter 16 on Model-Based Sonification):
> Think of the task of determining the contents of an opaque box by shaking it, or the task of diagnosing a malfunctioning car engine from the sounds it makes. [2](#02)  
So the idea is to create a tool that in a way resembles a musical instrument we can learn to _perform_ our data with.

We will now take a listen to some other examples that the authors provide to clarify the topic some more:

Of the many sonification examples that are presented by Thomas Hermann et al, here is one example that illustrates the idea behind Model-Based Sonification best: **The Data Sonogram Model Space**.  
In this model, the data is distributed in a scatter plot. The idea, now, is to use a mass-spring system (analoguely to mechanics) to define the sounding of each data particle.

### Examples

#### Example #1

--show data sonogram model space--

	scatter plot of data
	–> excite a shock wave in data space
	–> wave front excites mass-spring systems: each point is mass-spring system that oscillates once it is hit by shock wave

	provides information about data density and clustering
	parameters --> stiffness / damping of individual springs

	sound examples 16.2a-c

####



To wrap things up, I provide you the most concise summary of Model-Based Sonification:

> Model-Based Sonification is defined as the general term for all concrete sonification techniques that make use of dynamic models which mathematically describe the evolution of a system in time, parameterize and configure them during initialization with the available data and offer interaction/excitation modes to the user as the interface to actively query sonic responses which depend systematically upon the temporal evolution model. [2](#02)



## sources
<a name="01">[1]</a> - https://sonification.de/son/definition/ , 21.12.2019
<a name="02">[2]</a> - https://sonification.de/handbook/chapters/chapter16/, 07.01.2019

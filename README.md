# **KegsHACK-caffeine**
---
> **Evolving (and building) cars using the genetic algorithm**
---

## Project brief
This is a simple project where you can set up your own race track, with hills, troughs and jumps. Upon creating a track, you can set certain parameters for the Genetic algorithm. 
These parameters will be explained in detail later in the text, but with them you can modify the aim of the AI, the speed of the simulation and more!

**Now watch as the AI learns to traverse the rough terrain you have set up for it!**

## Controls
**WASD** or **middle click and drag** to move around

**left click** to add new flooring

**Q** to zoom in, **E** to zoom out

*The redder the wheels, the heavier they are!*

---

## Parameters

**Start generation:** Starts the simulation

**Reset:** Stops the simulation

**Generation size:** Changes the size of each generation in each iteration of the algorithm *(may get laggy)*

**Genetic algorithm focuses:**

  - *Maximize distance:* focusing on how far the AI can go.
  - *Minimize volume:* focusing on how small the car body can be.
  - *Maximize wheels:* focusing on how big the wheels can be. 
  - *balanced:* Aims to make an AI that goes fast and has minimized wheels
  - *Maximize weight:* focusing on how heavy the car can be

**Zoom:** zooms in and out
**View best only:** If toggled, the best performing car will be highlighted whilst the rest will be barely visible.
**Max lifetime:** How long a car will be alive for before being destroyed. Adjust for bigger courses. *(MAY RESET THE COURSE IF CHANGED)*
**Time scale:** Changes the speed of the simulation *(PHYSICS CAN GET WHACKY AT HIGHER SPEEDS)*

---

## Terminal output:

![image](https://user-images.githubusercontent.com/47331292/147858399-1279dde1-60a9-4540-8de0-7d08cc8e5845.png)
![image](https://user-images.githubusercontent.com/47331292/147858250-b33282fc-8081-41bf-ad81-4cecd36ae3c5.png)

If you run the program via the terminal, you will notice 2 numbers in every line being outputted to the terminal in each generation. The first number refers to the highest scoring individual in that generation, and the second number refers to the average fitness score of that generation. Use these numbers to draw a graph and see fitness over time!

---

## Program in action!

![image](https://user-images.githubusercontent.com/47331292/147823993-6ddd2e87-d312-4231-8a14-5953cc15d263.png)
![image](https://user-images.githubusercontent.com/47331292/147831645-4bd75e44-f484-408f-bb84-b2dd9870216f.png)

*The best AI after 100 generations of climbing a 40° angled slope. It tries to make itself heavier or lower its center of gravity to grip with the floor*

![image](https://user-images.githubusercontent.com/47331292/147824364-7010e388-2454-4671-91b8-a6a770ea4568.png)
![image](https://user-images.githubusercontent.com/47331292/147832313-c0f87060-807f-4054-bc3f-3c7692646b8f.png)
![image](https://user-images.githubusercontent.com/47331292/147832528-dc952046-70f8-4d93-8e6b-c7f0aaed103b.png)


*The best AI after 50 or so generations of descending 60° downward slope. Again, it tries to make itself heavier + having a low center of gravity, but it also tries to be faster by having bigger front wheels.*

*Other AI in this course adapted multiple wheels around the entire body, to maximize rolling effectiveness, whilst keeping themselves heavy to stay on the ground!*

![image](https://user-images.githubusercontent.com/47331292/147825500-b1481181-f8d0-42a3-a8d7-b53b242a394a.png)

*The best AI after 30 generations making a jump! This AI is extremely lightweight, to help go further*

![image](https://user-images.githubusercontent.com/47331292/147825584-a590bdac-0663-462d-8f52-2dd37c2967d6.png)

*Another AI making a jump! This one has a center of gravity at the back so it lands quickly after the jump to go further!*

![image](https://user-images.githubusercontent.com/47331292/147827001-3da7b41e-447d-4676-b9fc-8dfd734fc9e8.png)

*A nearly perfectly straight track. The best AI after nearly 300 generations took an odd car body shape, but the wheels are incredibly heavy, to maximize traction with the ground, and the center of gravity is as low as possible*

![image](https://user-images.githubusercontent.com/47331292/147827927-11f5f3ad-46ab-4ad8-8451-1dcb77248c91.png)
![image](https://user-images.githubusercontent.com/47331292/147828163-81e7356d-2fac-4fb0-bc5c-b2c7f55c9052.png)

*The best AI's after 50 generations crossing terrain with gaps. As we expected, there would be bigger wheels, but the top cars also managed to create a tank-like tracks to effectively create a bigger wheel! The AI had a higher weight, to increase traction.* 

![image](https://user-images.githubusercontent.com/47331292/147858902-9d0d2380-22fb-46f2-96a2-87583706abc7.png)

*This one's a very bumpy track. The AI developed a center of gravity close to the middle of the car and had wheels all throughout to thrust off of the bumps!*

---

## Limitations

There are some current limitations to the project. In terms of the program itself, running generations of size 50 can cause extreme lag for the first second of loading, due to creating unique objects each time. 

There's also the issue with *exploitation* happening too early on in the algorithm. In the machine-learning world, this is the same issue as over-fitting somewhat. For more difficult courses, such as jumps or obstacles, there tends to be large periods of low fitness:
![image](https://user-images.githubusercontent.com/47331292/147859198-97523536-855f-40f8-996e-af5155d2fc34.png)

Although there is a general upward trend, this large gap early on in the learning process is due to the exploitation of a certain car body which allowed for the AI to go far faster than its competitors. Due to elitism, this AI stayed for a while until it was randomly mutated, leading to a sharp drop (atleast that's what we think it is). 

This means that the algorithm won't converge very easily for more difficult scenarios. A solution to this would be to add decaying mutation rates or to find a better crossover function. But that's a long-term goal :-)

---

## Exploitation vs exploration

A benefit of this algorithm is that it continuously explores for different options throughout the simulation. Take a look at this graph of fitness over time:

![image](https://user-images.githubusercontent.com/47331292/147881129-31221003-fdca-4c1d-9e7a-9642dd93ac1b.png)

As you can see, the highest scoring AI does increaases more or so steadily over generations, whilst the average is constantly fluctuating. This can show the algorithm to be consistently mutating/finding new solutions without harming previous results, due to partial elitism selection. Whilst better methods DO exist, this is the best we could come up with in the duration of the hackathon (4 days). 

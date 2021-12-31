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

## Program in action!

![image](https://user-images.githubusercontent.com/47331292/147823993-6ddd2e87-d312-4231-8a14-5953cc15d263.png)

*The best AI after 100 generations of climbing a 40° angled slope. It tries to make itself heavier to grip with the floor*

![image](https://user-images.githubusercontent.com/47331292/147824364-7010e388-2454-4671-91b8-a6a770ea4568.png)

*The best AI after 50 or so generations of descending 60° downward slope. Again, it tries to make itself heavier + having a low center of gravity, but it also tries to be faster by having bigger wheels*

![image](https://user-images.githubusercontent.com/47331292/147825500-b1481181-f8d0-42a3-a8d7-b53b242a394a.png)

*The best AI after 30 generations making a jump! This AI is extremely lightweight, to help go further*

![image](https://user-images.githubusercontent.com/47331292/147825584-a590bdac-0663-462d-8f52-2dd37c2967d6.png)

*Another AI making a jump! This one has a center of gravity at the back so it lands quickly after the jump to go further!*

![image](https://user-images.githubusercontent.com/47331292/147827001-3da7b41e-447d-4676-b9fc-8dfd734fc9e8.png)

*A nearly perfectly straight track. The best AI after nearly 300 generations took an odd car body shape, but the wheels are incredibly heavy, to maximize traction with the ground, and the center of gravity is as low as possible*

![image](https://user-images.githubusercontent.com/47331292/147827927-11f5f3ad-46ab-4ad8-8451-1dcb77248c91.png)
![image](https://user-images.githubusercontent.com/47331292/147828163-81e7356d-2fac-4fb0-bc5c-b2c7f55c9052.png)

*The best AI's after 50 generations crossing terrain with gaps. As we expected, there would be bigger wheels, but the top cars also managed to create a tank-like tracks to effectively create a bigger wheel! The AI had a higher weight, to increase traction.* 

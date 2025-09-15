import React from 'react';
import { skills } from '../data/skills';

const Skills = ({ hasAnimated }) => {
    return (
        <section id="skills" className="py-16 px-6 bg-gray-50">
            <div className="max-w-6xl mx-auto">
                <div className={`transition-all duration-1000 delay-400 ${hasAnimated.skills ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}`}>
                    <h2 className="text-4xl font-bold mb-12 text-center">Skills & Technologies</h2>
                    <div className="grid md:grid-cols-3 gap-8">
                        {skills.map((skillGroup, index) => (
                            <div key={index} className="bg-white p-8 rounded-lg border border-gray-200">
                                <h3 className="text-xl font-semibold mb-6 text-center">{skillGroup.category}</h3>
                                <div className="space-y-3">
                                    {skillGroup.items.map((skill, skillIndex) => (
                                        <div key={skillIndex} className="flex items-center">
                                            <div className="w-2 h-2 bg-black rounded-full mr-3"></div>
                                            <span className="text-gray-700">{skill}</span>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </section>
    );
};

export default Skills; 
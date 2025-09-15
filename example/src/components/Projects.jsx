import React from 'react';
import ProjectCard from './ProjectCard';
import { projects } from '../data/projects';

const Projects = ({ hasAnimated }) => {
    return (
        <section id="projects" className="py-16 px-6">
            <div className="max-w-6xl mx-auto">
                <div className={`transition-all duration-1000 delay-300 ${hasAnimated.projects ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'}`}>
                    <h2 className="text-4xl font-bold mb-12 text-center">Featured Projects</h2>
                    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                        {projects.map((project, index) => (
                            <ProjectCard key={index} project={project} />
                        ))}
                    </div>
                </div>
            </div>
        </section>
    );
};

export default Projects; 